"""
Characterize the test examples for local.
"""
import os
import sys
import time
import hashlib
import argparse
import resource
from datetime import datetime

import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from scipy.stats import sem
from sklearn.metrics import accuracy_score
from sklearn.metrics import roc_auc_score
from sklearn.metrics import log_loss

here = os.path.abspath(os.path.dirname(__file__))
sys.path.insert(0, here + '/../')
sys.path.insert(0, here + '/../../')
import intent
import util as pp_util
from experiments import util



def filter_results(results, skip_list):
    """
    Remove results for methods on the skip list.
    """

    result = []

    for method, res in results:

        include = True
        for skip in skip_list:

            if skip in method:
                include = False
                break

        if include:
            result.append((method, res))

    return result


def experiment(args, logger, out_dir):

    # initialize experiment
    begin = time.time()

    # get dataset
    X_train, X_test, y_train, y_test, objective = util.get_data(args.data_dir, args.dataset)

    # get results
    results = pp_util.get_results(args, logger)
    results = filter_results(results, args.skip)
    color, line, label = pp_util.get_plot_dicts()

    assert objective == 'binary'

    # extract test examples
    _, res = results[0]
    test_idxs = res['test_idxs']
    test_proba = res['y_test_pred'][:, 0]
    test_pred = np.where(test_proba <= 0.5, 0, 1)

    y_test = y_test[test_idxs]
    test_proba = test_proba[test_idxs]
    test_pred = test_pred[test_idxs]

    # no. correct/incorrect predictions
    acc = accuracy_score(y_test, test_pred)
    auc = roc_auc_score(y_test, test_proba)
    logloss = log_loss(y_test, test_proba)

    logger.info(f'\nAcc.: {acc:.3f}, AUC: {auc:.3f}, log loss: {logloss:.3f}')

    # no. pos.
    pos = np.where(y_test == 1)[0]
    acc = accuracy_score(y_test[pos], test_pred[pos])
    logloss = log_loss(y_test[pos], test_proba[pos], labels=[0, 1])

    logger.info(f'No. pos.: {len(pos):,}, acc.: {acc:.3f}, log loss: {logloss:.3f}')

    # no neg.
    neg = np.where(y_test == 0)[0]
    acc = accuracy_score(y_test[neg], test_pred[neg])
    logloss = log_loss(y_test[neg], test_proba[neg], labels=[0, 1])

    logger.info(f'No. neg.: {len(neg):,}, acc.: {acc:.3f}, log loss: {logloss:.3f}')

    # plot arrived at leaf weights for 1+ test examples
    logger.info('\nLeaf Analysis')
    hp = util.get_hyperparams(tree_type=args.tree_type, dataset=args.dataset)
    tree = util.get_model(tree_type=args.tree_type, objective=objective, random_state=args.random_state)
    tree.set_params(**hp)
    tree = tree.fit(X_train, y_train)

    explainer = intent.TreeExplainer('boostin', {}, logger).fit(tree, X_train, y_train)
    test_leaves = explainer.model_.apply(X_test)  # shape=(no. test, no. boost, no. class)
    test_weights = explainer._get_leaf_weights(test_leaves)[test_idxs]  # shape=(no. test, no. boost, no. class)

    # pick test example
    test_idx = pos[0]  # relative index
    test_weight = test_weights[test_idx].flatten() # flatten across boosts/classes

    # # average test examples
    # mean_weights = np.mean(test_weights[neg], axis=0).flatten()  # shape=(no. boost * no. class)
    # std_weights = np.std(test_weights[neg], axis=0).flatten()  # shape=(no. boost * no. class)
    
    fig, ax = plt.subplots()
    sns.barplot(x=np.arange(len(test_weight)), y=test_weight, ax=ax)
    # sns.barplot(x=np.arange(len(mean_weights)), y=mean_weights, ci=std_weights, ax=ax)
    ax.set_xticklabels([])
    ax.set_title(f'Leaf Weights for Test Ex. {test_idx}')
    # ax.set_title(f'Avg. Leaf Weights')
    ax.set_ylabel('Leaf weight (1 / no. train at that leaf)')
    ax.set_xlabel('Tree index')
    ax.set_yscale('log')

    # ax.plot(np.arange(len(test_weight)), test_weight)

    plt_dir = os.path.join(args.out_dir, args.inf_obj)
    suffix = ''

    os.makedirs(plt_dir, exist_ok=True)
    fp = os.path.join(plt_dir, f'{args.dataset}')

    plt.tight_layout()
    plt.savefig(fp + suffix + '.png', bbox_inches='tight')
    plt.show()


def main(args):

    # get method params and unique settings hash
    _, hash_str = util.explainer_params_to_dict(args.method, vars(args))

    # create output dir
    out_dir = os.path.join(args.out_dir)

    # create output directory and clear previous contents
    os.makedirs(out_dir, exist_ok=True)

    logger = util.get_logger(os.path.join(out_dir, 'log.txt'))
    logger.info(args)
    logger.info(datetime.now())

    experiment(args, logger, out_dir)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    # I/O settings
    parser.add_argument('--data_dir', type=str, default='data/')
    parser.add_argument('--in_dir', type=str, default='output/influence/')
    parser.add_argument('--out_dir', type=str, default='output/plot/leaf_analysis/')

    # Data settings
    parser.add_argument('--dataset', type=str, default='surgical')

    # Tree-ensemble settings
    parser.add_argument('--tree_type', type=str, default='lgb')

    # Method settings
    parser.add_argument('--method', type=str, nargs='+',
                        default=['random', 'target', 'boostin', 'trex', 'similarity',
                                 'leaf_influence', 'loo', 'dshap'])
    parser.add_argument('--skip', type=str, nargs='+',
                        default=['minority', 'loss', 'boostin_9e', 'boostin_08'])
    parser.add_argument('--use_leaf', type=int, nargs='+', default=[1, 0])  # BoostIn
    parser.add_argument('--local_op', type=str, nargs='+', default=['normal', 'sign', 'sim'])  # BoostIn
    parser.add_argument('--update_set', type=int, nargs='+', default=[-1, 0])  # LeafInfluence

    parser.add_argument('--similarity', type=str, nargs='+', default=['dot_prod'])  # Similarity

    parser.add_argument('--kernel', type=str, nargs='+', default=['lpw'])  # Trex & Similarity
    parser.add_argument('--target', type=str, nargs='+', default=['actual'])  # Trex
    parser.add_argument('--lmbd', type=float, nargs='+', default=[0.003])  # Trex
    parser.add_argument('--n_epoch', type=str, nargs='+', default=[3000])  # Trex

    parser.add_argument('--trunc_frac', type=float, nargs='+', default=[0.25])  # DShap
    parser.add_argument('--check_every', type=int, nargs='+', default=[100])  # DShap

    parser.add_argument('--global_op', type=str, nargs='+', default=['self', 'expected'])  # TREX, LOO, DShap

    parser.add_argument('--n_jobs', type=int, default=-1)  # LOO and DShap
    parser.add_argument('--random_state', type=int, default=1)  # Trex, DShap, random

    # Experiment settings
    parser.add_argument('--inf_obj', type=str, default='local')
    # parser.add_argument('--zoom', type=float, default=2.0)
    # parser.add_argument('--n_sample', type=int, default=100)

    args = parser.parse_args()
    main(args)