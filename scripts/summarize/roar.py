"""
Aggregate results and organize them into one dict.
"""
import os
import sys
import time
import argparse
from datetime import datetime
from itertools import product

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import sem
from scipy.stats import gmean
from tqdm import tqdm

here = os.path.abspath(os.path.dirname(__file__))
sys.path.insert(0, here + '/../')
from postprocess import util as pp_util
from experiments import util as exp_util
from config import summ_args


def get_rank_df(df, skip_cols=[], remove_cols=[], ascending=False):
    """
    Rank values in dataframe.

    Input
        df: pd.DataFrame, input dataframe values.
        skip_cols: list, columns to skip.
        remove_cols: list, columns to remove from return dataframe (skipped too).
        ascending: bool, if True, rank 1 has lowest value.

    Return df with values replaced by rankings.
    """
    result_df = df.copy()

    cols = [c for c in df.columns if c not in skip_cols + remove_cols]
    df = df[cols]

    # drop rows in which all values are nan
    df = df.dropna(axis=0, how='all')
    result_df = result_df.dropna(axis=0, how='all', subset=cols)

    if ascending:
        df = df.fillna(1e300)  # missing values get last place ranking
        vals = df.values
        ranks = vals.argsort(axis=1).argsort(axis=1) + 1

    else:
        df = df.fillna(-1e300)
        vals = df.values
        ranks = np.flip(vals.argsort(axis=1), axis=1).argsort(axis=1) + 1

    for i, col in enumerate(cols):
        result_df[col] = ranks[:, i]

    drop_cols = [c for c in result_df.columns if c in remove_cols]
    result_df = result_df.drop(columns=drop_cols)

    return result_df


def process(args, out_dir, exp_hash, logger):
    begin = time.time()

    color, line, label = pp_util.get_plot_dicts()

    n_test = None

    rows = []
    rows2 = []
    rows3 = []

    logger.info('')
    for dataset in args.dataset_list:
        logger.info(f'{dataset}')

        exp_dir = os.path.join(args.in_dir,
                               dataset,
                               args.tree_type,
                               f'exp_{exp_hash}')

        res_list = pp_util.get_results(args, exp_dir, logger, progress_bar=False)
        res_list = pp_util.filter_results(res_list, args.skip)

        row = {'dataset': dataset, 'tree_type': args.tree_type}
        row2 = {'dataset': dataset, 'tree_type': args.tree_type}
        row3 = {'dataset': dataset, 'tree_type': args.tree_type}

        for j, (method, res) in enumerate(res_list):

            # sanity check
            if j == 0:
                n_test = res['loss'].shape[0]

            else:
                temp = res['loss'].shape[0]
                assert n_test == temp, f'Inconsistent no. test: {temp:,} != {n_test:,}'

            loss_mean = res['loss'].mean(axis=0)[args.ckpt]
            runtime = res['fit_time'] + res['inf_time']
            mem = res['max_rss_MB']

            row['remove_frac'] = res['remove_frac'][args.ckpt]
            row[f'{label[method]}'] = loss_mean

            row2['remove_frac'] = row['remove_frac']
            row2[f'{label[method]}'] = runtime

            row3['remove_frac'] = row['remove_frac']
            row3[f'{label[method]}'] = mem

        rows.append(row)
        rows2.append(row2)
        rows3.append(row3)

    df = pd.DataFrame(rows)
    df2 = pd.DataFrame(rows2)
    df3 = pd.DataFrame(rows3)

    # drop rows with missing values
    skip_cols = ['dataset', 'tree_type', 'remove_frac']
    remove_cols = ['LeafInfluence', 'LeafRefit']

    cols = [x for x in df.columns if x not in skip_cols + remove_cols]

    df = df.dropna(subset=cols)
    df2 = df2.dropna(subset=cols)
    df3 = df3.dropna(subset=cols)

    logger.info(f'\nLoss:\n{df}')
    logger.info(f'\nRuntime:\n{df2}')
    logger.info(f'\nMemory:\n{df3}')

    # compute rankings
    skip_cols = ['dataset', 'tree_type', 'remove_frac']

    rank_df = get_rank_df(df, skip_cols=skip_cols, remove_cols=['LeafInfluence', 'LeafRefit'])
    rank_li_df = get_rank_df(df[~pd.isna(df['LeafInfluence'])], skip_cols=skip_cols)
    logger.info(f'\nLoss ranking:\n{rank_df}')
    logger.info(f'\nLoss ranking (w/ leafinf):\n{rank_li_df}')

    logger.info(f'\nSaving results to {out_dir}...')

    df.to_csv(os.path.join(out_dir, 'loss.csv'), index=None)
    df2.to_csv(os.path.join(out_dir, 'runtime.csv'), index=None)
    df3.to_csv(os.path.join(out_dir, 'mem.csv'), index=None)

    rank_df.to_csv(os.path.join(out_dir, 'loss_rank.csv'), index=None)
    rank_li_df.to_csv(os.path.join(out_dir, 'loss_rank_li.csv'), index=None)

    logger.info(f'\nTotal time: {time.time() - begin:.3f}s')


def main(args):

    exp_dict = {'n_test': args.n_test, 'remove_frac': args.remove_frac}
    exp_hash = exp_util.dict_to_hash(exp_dict)

    out_dir = os.path.join(args.out_dir,
                           args.tree_type,
                           f'exp_{exp_hash}',
                           'summary',
                           f'ckpt_{args.ckpt}')

    # create logger
    os.makedirs(out_dir, exist_ok=True)
    logger = exp_util.get_logger(os.path.join(out_dir, 'log.txt'))
    logger.info(args)
    logger.info(datetime.now())

    process(args, out_dir, exp_hash, logger)


if __name__ == '__main__':
    main(summ_args.get_roar_args().parse_args())
