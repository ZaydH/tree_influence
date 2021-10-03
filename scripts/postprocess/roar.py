"""
Plot results for a single dataset.
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
import util
from experiments import util as exp_util
from config import post_args


def process(args, out_dir, logger):

    n_test = None
    results = []

    # get dataset
    X_train, X_test, y_train, y_test, objective = exp_util.get_data(args.data_dir, args.dataset)

    # get results
    exp_dict = {'n_test': args.n_test, 'remove_frac': args.remove_frac}
    exp_hash = exp_util.dict_to_hash(exp_dict)

    for in_dir in args.in_dir:

        exp_dir = os.path.join(in_dir,
                               args.dataset,
                               args.tree_type,
                               f'exp_{exp_hash}')

        res = util.get_results(args, exp_dir, logger)
        res = util.filter_results(res, args.skip)
        results += res

    color, line, label = util.get_plot_dicts()
    fig, axs = plt.subplots(1, 2, figsize=(9, 4))

    runtime_list = []
    method_list = []

    for i, (method, res) in enumerate(results):

        # sanity check
        if i == 0:
            n_test = res['loss'].shape[0]

        else:
            temp = res['loss'].shape[0]
            assert n_test == temp, f'Inconsistent no. test: {temp:,} != {n_test:,}'

        # plot loss
        x = res['remove_frac'] * 100
        y = res['loss'].mean(axis=0)
        y_err = sem(res['loss'], axis=0)
        y_err = y_err if args.std_err else None

        ax = axs[0]
        ax.errorbar(x, y, yerr=y_err, label=label[method], color=color[method],
                    linestyle=line[method], alpha=0.75)
        ax.set_xlabel('Train data removed (%)')
        ax.set_ylabel(f'Avg. example test loss')
        ax.legend(fontsize=6)

        runtime_list.append(res['fit_time'] + res['inf_time'])
        method_list.append(label[method])

    # plot runtimes
    ax = axs[1]
    ax.bar(method_list, runtime_list)
    ax.set_xlabel('Method')
    ax.set_ylabel(f'Time (s)')
    ax.set_yscale('log')
    plt.setp(ax.get_xticklabels(), ha='right', rotation=45)

    exp_dict = {'n_test': args.n_test, 'remove_frac': args.remove_frac}
    exp_hash = exp_util.dict_to_hash(exp_dict)

    plt_dir = os.path.join(args.out_dir,
                           args.tree_type,
                           f'exp_{exp_hash}')
    suffix = f'_{n_test}'
    os.makedirs(plt_dir, exist_ok=True)
    fp = os.path.join(plt_dir, f'{args.dataset}')

    plt.tight_layout()
    plt.savefig(fp + suffix + '.png', bbox_inches='tight')
    plt.show()


def main(args):

    out_dir = os.path.join(args.out_dir)

    # create logger
    os.makedirs(out_dir, exist_ok=True)
    logger = exp_util.get_logger(os.path.join(out_dir, 'log.txt'))
    logger.info(args)
    logger.info(datetime.now())

    process(args, out_dir, logger)


if __name__ == '__main__':
    main(post_args.get_roar_args().parse_args())
