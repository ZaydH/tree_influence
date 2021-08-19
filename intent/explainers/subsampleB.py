import time
import joblib

import numpy as np
from sklearn.base import clone

from .base import Explainer
from .parsers import util


class SubSampleB(Explainer):
    """
    Approximate Data Shapley. Trains many models on different
    subsets of the data to obtain expected memorization and influence.

    Global-Influence Semantics (i.e. memorization)
        - N/A

    Local-Influence Semantics (i.e. influence)
        - Inf.(x_i, x_t) := E[f_{w/o x_i}(x_t)] - E[f(x_t)]
        - Pos. value means removing x_i increases prediction (adding x_i decreases prediction).
        - Neg. value means removing x_i decreases prediction (adding x_i increases prediction).

    Note
        - Supports both GBDTs and RFs.
        - Supports parallelization.
    """
    def __init__(self, sub_frac=0.7, n_iter=4000, n_jobs=1, random_state=1, logger=None):
        """
        Input
            sub_frac: float, Fraction of train data to use for training.
            n_iter: int, No. sub-models to train.
            n_jobs: int, No. processes to run in parallel.
                -1 means use the no. of available CPU cores.
            random_state: int, Seed for reproducibility.
            logger: object, If not None, output to logger.
        """
        self.sub_frac = sub_frac
        self.n_iter = n_iter
        self.n_jobs = n_jobs
        self.random_state = random_state
        self.logger = logger

    def fit(self, model, X, y):
        """
        - Setup.

        Input
            model: tree ensemble.
            X: training data.
            y: training targets.
        """
        super().fit(model, X, y)
        X, y = util.check_data(X, y, objective=self.model_.objective)

        self.n_class_ = self.model_.n_class_
        self.loss_fn_ = util.get_loss_fn(self.model_.objective, self.model_.n_class_, self.model_.factor)
        self.X_train_ = X.copy()
        self.y_train_ = y.copy()
        self.objective_ = self.model_.objective

        # select no. processes to run in parallel
        if self.n_jobs == -1:
            n_jobs = joblib.cpu_count()

        else:
            assert self.n_jobs >= 1
            n_jobs = min(self.n_jobs, joblib.cpu_count())

        self.n_jobs_ = n_jobs
        self.original_model_ = model

        return self

    def get_global_influence(self, X=None, y=None):
        """
        - Provides a global importance to all training examples.

        Input
            X: 2d array of test data.
            y: 2d array of test targets.

        Return
            - 1d array of shape=(no. train,).
                * Arrays are returned in the same order as the traing data.
        """
        raise ValueError('Global influence not implemented!')

    def get_local_influence(self, X, y):
        """
        - Compute influence of each training instance on each test prediction.

        Input
            X: 2d array of test data.
            y: 1d array of test targets

        Return
            - 2d array of shape=(no. train, X.shape[0]).
                * Arrays are returned in the same order as the training data.
        """
        X, y = util.check_data(X, y, objective=self.model_.objective)
        return self._run_subsample(X_test=X, y_test=y)

    # private
    def _run_subsample(self, X_test=None, y_test=None):
        """
        - Train multiple models on different training subsets
            and measure expected change in train/test prediction.

        Return
            - 2d array of average marginals, shape=(no. train, 1 or X_test.shape[0]).
                * Arrays are returned in the same order as the traing data.
        """
        X_train = self.X_train_
        y_train = self.y_train_
        loss_fn = self.loss_fn_
        n_jobs = self.n_jobs_
        original_model = self.original_model_
        objective = self.objective_

        n_iter = self.n_iter
        sub_frac = self.sub_frac
        random_state = self.random_state

        start = time.time()
        if self.logger:
            self.logger.info('\n[INFO] computing influence values...')
            self.logger.info(f'[INFO] no. cpus: {n_jobs:,}...')

        # fit each model in parallel
        with joblib.Parallel(n_jobs=n_jobs) as parallel:

            # result containers
            in_pred = np.zeros((X_train.shape[0], X_test.shape[0]), dtype=util.dtype_t)
            out_pred = np.zeros((X_train.shape[0], X_test.shape[0]), dtype=util.dtype_t)

            # trackers
            fits_completed = 0
            fits_remaining = n_iter

            # get number of fits to perform for this iteration
            while fits_remaining > 0:
                n = min(100, fits_remaining)

                results = parallel(joblib.delayed(_run_iteration)
                                                 (original_model, X_train, y_train, X_test, y_test,
                                                  loss_fn, objective, sub_frac,
                                                  random_state + i) for i in range(fits_completed,
                                                                                   fits_completed + n))

                # synchronization barrier
                for preds, in_idxs in results:
                    out_idxs = np.setdiff1d(np.arange(X_train.shape[0]), in_idxs)

                    for test_idx, pred in enumerate(preds):
                        in_pred[in_idxs, test_idx] += pred
                        out_pred[out_idxs, test_idx] += pred

                fits_completed += n
                fits_remaining -= n

                if self.logger:
                    cum_time = time.time() - start
                    self.logger.info(f'[INFO] fits: {fits_completed:>7,} / {n_iter:,}'
                                     f', cum. time: {cum_time:.3f}s')

        # compute difference in expected predictions
        influence = (out_pred / n_iter) - (in_pred / n_iter)

        return influence


def _run_iteration(model, X_train, y_train, X_test, y_test, loss_fn, objective, sub_frac, seed):
    """
    Fit model after leaving out the specified `train_idx` train example.

    Return
        - 1d array of shape=(X_test.shape[0],) or single float.

    Note
        - Parallelizable method.
    """
    rng = np.random.default_rng(seed)

    idxs = rng.choice(X_train.shape[0], size=int(X_train.shape[0] * sub_frac), replace=False)
    new_X_train = X_train[idxs].copy()
    new_y_train = y_train[idxs].copy()

    new_model = clone(model).fit(new_X_train, new_y_train)
    pred = _get_pred(loss_fn, new_model, objective, X=X_test, y=y_test)  # shape=(X_test.shape[0],)

    return pred, idxs


def _get_pred(loss_fn, model, objective, X, y, batch=False):
    """
    Return
        - 1d array of individual predictions of shape=(X.shape[0],),
            unless batch=True, then return a single float.

    Note
        - Parallelizable method.
    """
    if objective == 'regression':
        y_pred = model.predict(X)  # shape=(X.shape[0],)

    elif objective == 'binary':
        y_pred = model.predict_proba(X)[:, 1]  # 1d arry of pos. probabilities, shape=(X.shape[0],)

    else:  # TEMP: returns prediction of first class, probably not ideal
        assert objective == 'multiclass'
        y_pred = model.predict_proba(X)[:, 0]  # shape=(X.shape[0],)

    result = y_pred

    return result
