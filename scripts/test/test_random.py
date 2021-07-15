import os
import sys
import argparse

here = os.path.abspath(os.path.dirname(__file__))
sys.path.insert(0, here + '/../../')
import test_util
from intent.explainers import Random


def main(args):

    # explainer arguments
    kwargs = {'random_state': args.random_state}

    # tests
    test_util.test_global_influence_regression(args, Random, 'random', kwargs)
    test_util.test_global_influence_binary(args, Random, 'random', kwargs)
    test_util.test_global_influence_multiclass(args, Random, 'random', kwargs)
    test_util.test_local_influence_regression(args, Random, 'random', kwargs)
    test_util.test_local_influence_binary(args, Random, 'random', kwargs)
    test_util.test_local_influence_multiclass(args, Random, 'random', kwargs)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    # data settings
    parser.add_argument('--n_train', type=int, default=100)
    parser.add_argument('--n_test', type=int, default=2)
    parser.add_argument('--n_class', type=int, default=3)
    parser.add_argument('--n_feat', type=int, default=10)

    # tree-ensemble settings
    parser.add_argument('--n_tree', type=int, default=100)
    parser.add_argument('--max_depth', type=int, default=7)
    parser.add_argument('--tree_type', type=str, default='lgb')
    parser.add_argument('--model_type', type=str, default='dummy')
    parser.add_argument('--rs', type=int, default=1)

    # explainer settings
    parser.add_argument('--random_state', type=int, default=1)

    args = parser.parse_args()

    main(args)