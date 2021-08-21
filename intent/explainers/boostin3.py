import numpy as np

from .base import Explainer
from .parsers import util


class BoostIn3(Explainer):
    """
    Explainer that adapts the TracIn method to tree ensembles.

    Global-Influence Semantics
        - N/A

    Local-Influence Semantics
        - Inf.(x_i, x_t) = sum grad(x_t) * leaf_der w.r.t. x_i * learning_rate over all boosts.
        - Pos. value means a decrease in test loss (a.k.a. proponent, helpful).
        - Neg. value means an increase in test loss (a.k.a. opponent, harmful).

    Reference
        - https://github.com/frederick0329/TracIn

    Paper
        - https://arxiv.org/abs/2002.08484

    Note
        - Only support GBDTs.
    """
    def __init__(self, local_op='normal', logger=None):
        """
        Input
            local_op: str, Configures how the local influence is computed.
            logger: object, If not None, output to logger.
        """
        assert local_op in ['normal']
        self.local_op = local_op
        self.logger = logger

    def fit(self, model, X, y):
        """
        - Convert model to internal standardized tree structure.
        - Precompute gradients and leaf indices for each x in X.

        Input
            model: tree ensemble.
            X: 2d array of train examples.
            y: 1d array of train targets.
        """
        super().fit(model, X, y)
        X, y = util.check_data(X, y, objective=self.model_.objective)

        assert self.model_.tree_type != 'rf', 'RF not supported for BoostIn2'

        self.n_train_ = X.shape[0]
        self.loss_fn_ = util.get_loss_fn(self.model_.objective, self.model_.n_class_, self.model_.factor)

        self.train_leaf_dvs_ = self._compute_leaf_derivatives(X, y)  # (X.shape[0], n_boost, n_class)
        self.train_leaf_idxs_ = self.model_.apply(X)  # shape=(X.shape[0], no. boost, no. class)

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
        - Computes effect of each train example on the loss of the test example.

        Input
            X: 2d array of test data.
            y: 2d array of test targets.

        Return
            - 2d array of shape=(no. train, X.shape[0]).
                * Array is returned in the same order as the training data.

        Note
            - Attribute train attribution to the test loss ONLY if the train example
                is in the same leaf(s) as the test example.
        """
        X, y = util.check_data(X, y, objective=self.model_.objective)

        # result container, shape=(X.shape[0], no. train, no. class)
        influence = np.zeros((self.n_train_, X.shape[0]), dtype=util.dtype_t)

        # get change in leaf derivatives and test prediction derivatives
        train_leaf_dvs = self.train_leaf_dvs_  # (no. train, no. boost, no. class)
        test_gradients = self._compute_gradients(X, y)  # shape=(X.shape[0], no. boost, no. class)

        # get leaf indices each example arrives in
        train_leaf_idxs = self.train_leaf_idxs_  # shape=(no. train, no. boost, no. class)
        test_leaf_idxs = self.model_.apply(X)  # shape=(X.shape[0], no. boost, no. class)

        # compute attributions for each test example
        for i in range(X.shape[0]):
            mask = np.where(train_leaf_idxs == test_leaf_idxs[i], 1, 0)  # shape=(no. train, no. boost, no. class)
            prod = train_leaf_dvs * -test_gradients[i] * mask  # shape=(no. train, no. boost, no. class)

            # sum over boosts and classes
            influence[:, i] = np.sum(prod, axis=(1, 2))  # shape=(no. train,)

        return influence

    # private
    def _compute_gradients(self, X, y):
        """
        - Compute gradients for all train instances across all boosting iterations.

        Input
            X: 2d array of train examples.
            y: 1d array of train targets.

        Return
            - 3d array of shape=(X.shape[0], no. boost, no. class).
        """
        n_train = X.shape[0]

        trees = self.model_.trees
        n_boost = self.model_.n_boost_
        n_class = self.model_.n_class_
        bias = self.model_.bias

        current_approx = np.tile(bias, (n_train, 1)).astype(util.dtype_t)  # shape=(X.shape[0], no. class)
        gradients = np.zeros((n_train, n_boost, n_class))  # shape=(X.shape[0], no. boost, no. class)

        # compute gradients for each boosting iteration
        for boost_idx in range(n_boost):

            gradients[:, boost_idx, :] = self.loss_fn_.gradient(y, current_approx)  # shape=(no. train, no. class)

            # update approximation
            for class_idx in range(n_class):
                current_approx[:, class_idx] += trees[boost_idx, class_idx].predict(X)

        return gradients

    def _compute_leaf_derivatives(self, X, y):
        """
        - Compute leaf derivatives for all train instances across all boosting iterations.

        Input
            X: 2d array of train examples.
            y: 1d array of train targets.

        Return
            - 3d array of shape=(X.shape[0], no. boost, no. class).

        Note
            - It is assumed that the leaf estimation method is 'Newton'.
        """
        n_train = X.shape[0]

        trees = self.model_.trees
        n_boost = self.model_.n_boost_
        n_class = self.model_.n_class_
        bias = self.model_.bias
        l2_leaf_reg = self.model_.l2_leaf_reg
        lr = self.model_.learning_rate

        # get leaf info
        leaf_counts = self.model_.get_leaf_counts()  # shape=(no. boost, no. class)
        leaf_idxs = self.model_.apply(X)  # shape=(X.shape[0], no. boost, no. class)

        # intermediate container
        current_approx = np.tile(bias, (n_train, 1)).astype(util.dtype_t)  # shape=(X.shape[0], no. class)

        # result container
        leaf_dvs = np.zeros((n_train, n_boost, n_class), dtype=util.dtype_t)  # shape=(X.shape[0], n_boost, n_class)

        # compute gradients for each boosting iteration
        for boost_idx in range(n_boost):

            g = self.loss_fn_.gradient(y, current_approx)  # shape=(no. train, no. class)
            h = self.loss_fn_.hessian(y, current_approx)  # shape=(no. train, no. class)

            for class_idx in range(n_class):
                leaf_count = leaf_counts[boost_idx, class_idx]
                leaf_vals = trees[boost_idx, class_idx].get_leaf_values()  # shape=(no. leaves,)

                for leaf_idx in range(leaf_count):
                    leaf_docs = np.where(leaf_idx == leaf_idxs[:, boost_idx, class_idx])[0]

                    # compute leaf difference after removing each train example in `leaf_docs`
                    alpha1 = leaf_vals[leaf_idx]

                    numerator = np.sum(g[leaf_docs, class_idx]) - g[leaf_docs, class_idx]  # shape=(no. docs,)
                    denominator = np.sum(h[leaf_docs, class_idx]) - h[leaf_docs, class_idx] + l2_leaf_reg
                    alpha2 = numerator / denominator * lr

                    leaf_dvs[leaf_docs, boost_idx, class_idx] = alpha1 - alpha2  # (no. docs,)

                # update approximation
                current_approx[:, class_idx] += trees[boost_idx, class_idx].predict(X)

        return leaf_dvs