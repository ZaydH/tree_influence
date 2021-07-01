import numpy as np
from sklearn.preprocessing import OneHotEncoder


def check_data(X, y=None, objective='regression'):
    """
    Make sure the data is valid.
    """
    X = check_input_data(X)

    if y is not None:

        if objective == 'regression':
            y = check_regression_targets(y)

        elif objective in ['binary', 'multiclass']:
            y = check_classification_labels(y)

        else:
            raise ValueError(f'Unknown objective {objective}')

        result = (X, y)

    else:
        result = X

    return result


def check_input_data(X):
    """
    Makes sure data is of np.float32 type.
    """
    assert X.ndim == 2
    if X.dtype != np.float32:
        X = X.astype(np.float32)
    return X


def check_classification_labels(y):
    """
    Makes sure labels are of np.int32 type.
    """
    assert y.ndim == 1
    if y.dtype != np.int32:
        y = y.astype(np.int32)
    return y


def check_regression_targets(y):
    """
    Makes sure regression targets are of np.float32 type.
    """
    assert y.ndim == 1
    if y.dtype != np.float32:
        y = y.astype(np.float32)
    return y


def sigmoid(z):
    """
    Squashes elements in z to be between 0 and 1.
    """
    return 1.0 / (1.0 + np.exp(-z))


def softmax(z):
    """
    Differentiable argmax function.

    Input
        z: 2d array of values.

    Returns 2d array of probability distributions of shape=z.shape.
    """
    if type(z) == list:
        z = np.array(z, dtype=np.float32)
    if z.ndim == 1:
        z = z.reshape(1, -1)  # shape=(1, len(z))
    centered_exponent = np.exp(z - np.max(z, axis=1, keepdims=True))
    return centered_exponent / np.sum(centered_exponent, axis=1, keepdims=True)


def logsumexp(z):
    """
    Input
        z: 2d array of values.

    Returns 2d array of normalization constants in log space, shape=(1, len(z)).
    """
    if z.ndim == 1:
        z = z.reshape(1, -1)  # shape=(1, len(z))

    maximum = np.max(z, axis=1, keepdims=True)
    return maximum + np.log(np.sum(np.exp(z - maximum), axis=1, keepdims=True))


def logit(z):
    """
    Inverse of sigmoid.
    """
    return np.log(z / (1 - z))


def to_np(x):
    """
    Convert torch tensor to numpy array.
    """
    return x.data.cpu().numpy()


class SquaredLoss(object):
    """
    Squared loss.

    Modified from:
        - https://github.com/bsharchilev/influence_boosting/blob/master/influence_boosting/loss.py

    Note
        - y and yhat could be swapped and the gradient would still be the same.
        - y_raw and y_hat are equivalent.
        - Shape of y and y_raw are (no. examples, 1). This is to be
            compatible with multiclass models.
    """

    def __call__(self, y, y_raw):
        """
        Input
            y: 2d array of regression values.
            y_raw: 2d array of predicted values.

        Return
            2d array of mean-squared error losses.
        """
        y, y_raw = self._check_y(y, y_raw)
        return 0.5 * (y - y_raw) ** 2

    def gradient(self, y, y_raw):
        """
        Input
            y: 2d array of regression values.
            y_raw: 2d array of predicted values.

        Returns 2d array of gradients w.r.t. the prediction.
        """
        y, y_raw = self._check_y(y, y_raw)
        return y_raw - y

    def hessian(self, y, y_raw):
        """
        Input
            y: 2d array of regression values.
            y_raw: 2d array of predicted values.

        Returns 2d array of second-order derivatives w.r.t. the prediction.
        """
        y, y_raw = self._check_y(y, y_raw)
        return np.ones_like(y)

    def third(self, y, y_raw):
        """
        Input
            y: 2d array of regression values.
            y_raw: 2d array of predicted values.

        Returns 2d array of third-order derivatives w.r.t. the prediction.
        """
        y, y_raw = self._check_y(y, y_raw)
        return np.zeros_like(y)

    # private
    def _check_y(self, y, y_raw):
        """
        Make sure y and y_raw are in shape=(no. examples, 1).
        """
        if y.ndim == 1:
            y = y.reshape(-1, 1)

        if y_raw.ndim == 1:
            y_raw = y_raw.reshape(-1, 1)

        assert y.ndim == 2
        assert y.shape[1] == 1
        assert y.shape == y_raw.shape

        return y, y_raw


class LogisticLoss(object):
    """
    Sigmoid + Binary Cross-entropy.

    A.K.A. log loss, binomial deviance, binary objective.

    Inputs are unnormalized log probs.

    Modified from:
        - https://github.com/bsharchilev/influence_boosting/blob/master/influence_boosting/loss.py
        - https://github.com/eriklindernoren/ML-From-Scratch/blob/
            a2806c6732eee8d27762edd6d864e0c179d8e9e8/mlfromscratch/supervised_learning/xgboost.py

    Note
        - Shape of y and y_raw are (no. examples, 1). This is to be
            compatible with multiclass models.
    """

    def __call__(self, y, y_raw, eps=1e-15):
        """
        Clip yhat to just above 0 and just below 1
        since log is undefined for 0.

        Input
            y: 2d array of 0 and 1 labels.
            y_raw: 2d array of unnormalized log probs.

        Return 2d array of neg. log losses.
        """
        assert np.all(np.unique(y) == np.array([0, 1]))

        y, y_raw = self._check_y(y, y_raw)

        y_hat = sigmoid(y_raw)
        y_hat = np.clip(y_hat, eps, 1 - eps)  # prevent log(0)
        losses = -(y * np.log(y_hat) + (1 - y) * np.log(1 - y_hat))

        return losses

    def gradient(self, y, y_raw):
        """
        Input
            y: 2d array of 0 and 1 labels.
            yhat: 2d array of pre-activation values.

        Returns 2d array of gradients w.r.t. the prediction.
        """
        y, y_raw = self._check_y(y, y_raw)
        y_hat = sigmoid(y_raw)
        return y_hat - y

    def hessian(self, y, y_raw):
        """
        Input
            y: 1d array of 0 and 1 labels.
            yhat: 1d array of pre-activation values.

        Returns 1d array of second-order gradients w.r.t. the prediction.
        """
        y, y_raw = self._check_y(y, y_raw)
        y_hat = sigmoid(y_raw)
        return y_hat * (1 - y_hat)

    def third(self, y, y_raw):
        """
        Input
            y: 2d array of 0 and 1 labels.
            yhat: 2d array of pre-activation values.

        Returns 2d array of third-order gradients w.r.t. the prediction.
        """
        y, y_raw = self._check_y(y, y_raw)
        y_hat = sigmoid(y_raw)
        return y_hat * (1 - y_hat) * (1 - 2 * y_hat)

    # private
    def _check_y(self, y, y_raw):
        """
        Make sure y and y_raw are in shape=(no. examples, 1).
        """
        if y.ndim == 1:
            y = y.reshape(-1, 1)

        if y_raw.ndim == 1:
            y_raw = y_raw.reshape(-1, 1)

        assert y.ndim == 2
        assert y.shape[1] == 1
        assert y.shape == y_raw.shape

        return y, y_raw


class SoftmaxLoss(object):
    """
    Softmax + Cross-entropy.

    A.K.A. Multiclass log loss, multinomial deviance, multiclass objective.

    Inputs are unnormalized log probs.

    Modified from:
        - https://github.com/bsharchilev/influence_boosting/blob/master/influence_boosting/loss.py
    """
    def __init__(self, factor, n_class):
        """
        Input
            factor: float, number to multiply hessian and third to rescale
                the redundant class; typically (no. class) / (no. class - 1).
        """
        self.factor = factor
        self.n_class = n_class

    def __call__(self, y, y_raw):
        """
        Input
            y: 2d array of one-hot-encoded labels; shape=(no. examples, no. classes).
            y_raw: 2d array of unnormalized log probs.; shape=(no. examples, no. classes).

        Return losses of shape=y_raw.shape.
        """
        y = self._check_y(y)
        y_raw_norm = y_raw - logsumexp(y_raw)  # normalize log probs in log space
        return -np.sum(y * y_raw_norm, axis=1)

    def gradient(self, y, y_raw):
        """
        Input
            y: 2d array of one-hot-encoded labels, shape=(no. examples, no. classes).
            y_hat: 2d array of pre-activation values, shape=(no. examples, no. classes).

        Returns 2d array of gradients w.r.t. the prediction; shape=(no. examples, no. classes).
        """
        y = self._check_y(y)
        y_hat = softmax(y_raw)
        return y_hat - y

    def hessian(self, y, y_raw):
        """
        Input
            y: 2d array of one-hot-encoded labels, shape=(no. examples, no. classes).
            y_hat: 2d array of pre-activation values, shape=(no. examples, no. classes).

        Returns 1d array of second-order gradients w.r.t. the prediction; shape=(no. examples, no. classes).
        """
        y = self._check_y(y)
        y_hat = softmax(y_raw)
        return y_hat * (1 - y_hat) * self.factor

    def third(self, y, y_raw):
        """
        Input
            y: 2d array of one-hot-encoded labels, shape=(no. examples, no. classes).
            y_hat: 2d array of pre-activation values, shape=(no. examples, no. classes).

        Returns 2d array of third-order gradients w.r.t. the prediction; shape=(no. examples, no. classses).
        """
        y = self._check_y(y)
        y_hat = softmax(y_raw)
        return y_hat * (1 - y_hat) * (1 - 2 * y_hat) * self.factor

    # private
    def _check_y(self, y):
        """
        Converts 1d array of multiclass labels to a 2d array of one-hot encoded labels.
        """
        if y.ndim == 1:
            class_cat = [np.arange(self.n_class).tolist()]
            y = y.reshape(-1, 1)
            y = OneHotEncoder(categories=class_cat, sparse=False, dtype=np.float32).fit_transform(y)
        return y
