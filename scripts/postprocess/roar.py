"""
Aggregate results and organize them into one dict.
"""
import os
import sys
import argparse
from datetime import datetime
from itertools import product

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import sem
from tqdm import tqdm

here = os.path.abspath(os.path.dirname(__file__))
sys.path.insert(0, here + '/../')
from experiments import util


def get_result(template, in_dir):
    """
    Obtain the results for this baseline method.
    """
    result = template.copy()

    fp = os.path.join(in_dir, 'results.npy')

    if not os.path.exists(fp):
        result = None

    else:
        d = np.load(fp, allow_pickle=True)[()]
        result.update(d)

    return result


def create_csv(args, out_dir, logger):

    logger.info('\nGathering results...')

    # get str for influence objective
    inf_type = 'global'
    if args.inf_obj == 'local':
        inf_type = f'local_{args.test_select}'

    experiment_settings = list(product(*[args.method, args.use_leaf, args.update_set,
                                         args.kernel, args.target, args.lmbd, args.n_epoch,
                                         args.use_alpha, args.trunc_frac, args.check_every]))

    visited = set()
    results = []

    for items in tqdm(experiment_settings):

        method, use_leaf, update_set, kernel, target, lmbd, n_epoch, use_alpha, trunc_frac, check_every = items

        template = {'method': method,
                    'use_leaf': use_leaf,
                    'update_set': update_set,
                    'kernel': kernel,
                    'target': target,
                    'lmbd': lmbd,
                    'n_epoch': n_epoch,
                    'use_alpha': use_alpha,
                    'trunc_frac': trunc_frac,
                    'check_every': check_every,
                    'random_state': args.random_state,
                    'n_jobs': args.n_jobs}

        _, hash_str = util.explainer_params_to_dict(method, template)

        exp_dir = os.path.join(args.in_dir,
                               args.dataset,
                               args.tree_type,
                               f'rs_{args.random_state}',
                               inf_type,
                               f'{method}_{hash_str}')

        method_id = f'{method}_{hash_str}'

        # skip empty experiments
        if not os.path.exists(exp_dir) or method_id in visited:
            continue

        # add results to result dict
        else:
            visited.add(method_id)

            result = get_result(template, exp_dir)
            if result is not None:
                results.append((method, result))

    # plot results
    color = {'random': 'blue', 'boostin': 'orange', 'trex': 'green', 'loo': 'red',
             'dshap': 'brown', 'leaf_influence': 'purple'}

    line = {'random': 'blue', 'boostin': 'orange', 'trex': 'green', 'loo': 'red',
            'dshap': 'brown', 'leaf_influence': 'purple'}

    if args.inf_obj == 'global':
        fig, axs = plt.subplots(1, 3, figsize=(12, 4))
        for i, metric in enumerate(args.metric):
            ax = axs[i]
            if i == 1:
                ax.set_title(f'{args.dataset}')

            for method, res in results:
                x, y = res['remove_frac'] * 100, res[metric]
                if args.zoom:
                    x, y = x[:20], y[:20]
                ax.plot(x, y, label=method, color=color[method], alpha=0.75)
                ax.set_xlabel('Train data removed (%)')
                ax.set_ylabel(f'Test {metric}')
                ax.legend(fontsize=6)

    # local
    else:
        fig, ax = plt.subplots()
        for method, res in results:
            x, y = res['remove_frac'].mean(axis=0) * 100, res['loss'].mean(axis=0)
            y_err = sem(res['loss'], axis=0)
            if args.zoom:
                x, y, y_err = x[:20], y[:20], y_err[:20]
            ax.errorbar(x, y, yerr=y_err if args.std_err else None, label=method, color=color[method], alpha=0.75)
            ax.set_title(f'{args.dataset}')
            ax.set_xlabel('Train data removed (%)')
            ax.set_ylabel(f'Avg. example test loss')
            ax.legend(fontsize=6)

    plt_dir = os.path.join(args.out_dir, args.inf_obj)
    if args.zoom:
        plt_dir = os.path.join(plt_dir, 'zoom')
    os.makedirs(plt_dir, exist_ok=True)
    fp = os.path.join(plt_dir, f'{args.dataset}')

    plt.tight_layout()
    plt.savefig(fp + '.png', bbox_inches='tight')
    plt.show()


def main(args):

    out_dir = os.path.join(args.out_dir)

    # create logger
    os.makedirs(out_dir, exist_ok=True)
    logger = util.get_logger(os.path.join(out_dir, 'log.txt'))
    logger.info(args)
    logger.info(datetime.now())

    create_csv(args, out_dir, logger)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    # I/O settings
    parser.add_argument('--in_dir', type=str, default='output/roar/', help='input directory.')
    parser.add_argument('--out_dir', type=str, default='output/plot/roar/', help='output directory.')

    # experiment settings
    parser.add_argument('--dataset', type=str, default='surgical')
    parser.add_argument('--tree_type', type=str, default='lgb')
    parser.add_argument('--inf_obj', type=str, default='global')
    parser.add_argument('--test_select', type=str, default='random')  # local
    parser.add_argument('--random_state', type=int, default=1)
    parser.add_argument('--n_jobs', type=int, default=-1)  # LOO and DShap

    # method settings
    parser.add_argument('--method', type=str, nargs='+',
                        default=['random', 'boostin', 'trex', 'leaf_influence', 'loo', 'dshap'])
    parser.add_argument('--use_leaf', type=int, nargs='+', default=[1, 0])  # BoostIn
    parser.add_argument('--update_set', type=int, nargs='+', default=[-1, 0])  # LeafInfluence

    parser.add_argument('--kernel', type=str, nargs='+', default=['lpw'])  # Trex
    parser.add_argument('--target', type=str, nargs='+', default=['actual'])  # Trex
    parser.add_argument('--lmbd', type=float, nargs='+', default=[0.003])  # Trex
    parser.add_argument('--n_epoch', type=str, nargs='+', default=[3000])  # Trex
    parser.add_argument('--use_alpha', type=int, nargs='+', default=[0, 1])  # Trex

    parser.add_argument('--trunc_frac', type=float, nargs='+', default=[0.25, 0.5])  # DShap
    parser.add_argument('--check_every', type=int, nargs='+', default=[100])  # DShap

    # result settings
    parser.add_argument('--metric', type=str, nargs='+', default=['mse', 'acc', 'auc'])
    parser.add_argument('--std_err', type=int, default=0)
    parser.add_argument('--zoom', type=int, default=0)

    args = parser.parse_args()
    main(args)