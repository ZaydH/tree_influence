import os
import sys
import argparse

here = os.path.abspath(os.path.dirname(__file__))
sys.path.insert(0, here + '/../../')
import test_util
from intent.explainers import Similarity2


def main(args):

    # explainer arguments
    kwargs = {'similarity': args.similarity, 'kernel': args.kernel}

    # tests
    test_util.test_local_influence_regression(args, Similarity2, 'Similarity2', kwargs)
    test_util.test_local_influence_binary(args, Similarity2, 'Similarity2', kwargs)
    test_util.test_local_influence_multiclass(args, Similarity2, 'Similarity2', kwargs)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    # data settings
    parser.add_argument('--n_train', type=int, default=100)
    parser.add_argument('--n_test', type=int, default=100)
    parser.add_argument('--n_local', type=int, default=2)
    parser.add_argument('--n_class', type=int, default=3)
    parser.add_argument('--n_feat', type=int, default=10)

    # tree-ensemble settings
    parser.add_argument('--n_tree', type=int, default=100)
    parser.add_argument('--n_leaf', type=int, default=31)
    parser.add_argument('--max_depth', type=int, default=7)
    parser.add_argument('--tree_type', type=str, default='lgb')
    parser.add_argument('--model_type', type=str, default='dummy')
    parser.add_argument('--rs', type=int, default=1)

    # explainer settings
    parser.add_argument('--similarity', type=str, default='dot_prod')
    parser.add_argument('--kernel', type=str, default='lpw')

    args = parser.parse_args()

    main(args)