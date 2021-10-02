"""
Summarize results across all datasets.
"""
import os
import sys
import time
import argparse
from datetime import datetime
from itertools import product

import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from scipy.stats import sem
from tqdm import tqdm

here = os.path.abspath(os.path.dirname(__file__))
sys.path.insert(0, here + '/../')
from experiments import util as exp_util
from postprocess import util as pp_util
from config import summ_args
from summarize.roar import get_rank_df


def process(args, exp_hash, out_dir, logger):
    begin = time.time()
    color, line, label = pp_util.get_plot_dicts()

    rows_loss = []
    rows_acc = []
    rows_auc = []

    for dataset in args.dataset_list:

        exp_dir = os.path.join(args.in_dir,
                               dataset,
                               args.tree_type,
                               f'exp_{exp_hash}')

        res_list = pp_util.get_results(args, exp_dir, logger, progress_bar=False)
        res_list = pp_util.filter_results(res_list, args.skip)

        row_loss = {'dataset': dataset, 'tree_type': args.tree_type}
        row_acc = row_loss.copy()
        row_auc = row_loss.copy()

        for method, res in res_list:

            row_loss['poison_frac'] = res['poison_frac'][args.ckpt]
            row_loss[f'{label[method]}'] = res['loss'][args.ckpt]

            row_acc['poison_frac'] = res['poison_frac'][args.ckpt]
            row_acc[f'{label[method]}'] = res['acc'][args.ckpt]

            row_auc['poison_frac'] = res['poison_frac'][args.ckpt]
            row_auc[f'{label[method]}'] = res['auc'][args.ckpt]

        rows_loss.append(row_loss)
        rows_acc.append(row_acc)
        rows_auc.append(row_auc)

    df_loss = pd.DataFrame(rows_loss).replace(-1, np.nan)
    df_acc = pd.DataFrame(rows_acc).replace(-1, np.nan)
    df_auc = pd.DataFrame(rows_auc).replace(-1, np.nan)

    logger.info(f'\nLoss:\n{df_loss}')
    logger.info(f'\nAccuracy:\n{df_acc}')
    logger.info(f'\nAUC:\n{df_auc}')

    # compute rankings
    skip_cols = ['dataset', 'tree_type', 'poison_frac']
    remove_cols = ['Leaf Inf.', 'Leaf Refit']

    rank_df_loss = get_rank_df(df_loss, skip_cols=skip_cols, remove_cols=remove_cols)
    rank_df_acc = get_rank_df(df_acc, skip_cols=skip_cols, remove_cols=remove_cols, ascending=True)
    rank_df_auc = get_rank_df(df_auc, skip_cols=skip_cols, remove_cols=remove_cols, ascending=True)

    rank_li_df_loss = get_rank_df(df_loss[~pd.isna(df_loss['Leaf Inf.'])], skip_cols)
    rank_li_df_acc = get_rank_df(df_acc[~pd.isna(df_acc['Leaf Inf.'])], skip_cols, ascending=True)
    rank_li_df_auc = get_rank_df(df_auc[~pd.isna(df_auc['Leaf Inf.'])], skip_cols, ascending=True)

    logger.info(f'\nLoss ranking:\n{rank_df_loss}')
    logger.info(f'\nLoss ranking (w/ leafinf):\n{rank_li_df_loss}')

    logger.info(f'\nAcc. ranking:\n{rank_df_acc}')
    logger.info(f'\nAcc. ranking (w/ leafinf):\n{rank_li_df_acc}')

    logger.info(f'\nAUC ranking:\n{rank_df_auc}')
    logger.info(f'\nAUC ranking (w/ leafinf):\n{rank_li_df_auc}')

    logger.info(f'\nSaving results to {out_dir}/...')

    df_loss.to_csv(os.path.join(out_dir, 'loss.csv'), index=None)
    df_acc.to_csv(os.path.join(out_dir, 'acc.csv'), index=None)
    df_auc.to_csv(os.path.join(out_dir, 'auc.csv'), index=None)

    rank_df_loss.to_csv(os.path.join(out_dir, 'loss_rank.csv'), index=None)
    rank_df_acc.to_csv(os.path.join(out_dir, 'acc_rank.csv'), index=None)
    rank_df_auc.to_csv(os.path.join(out_dir, 'auc_rank.csv'), index=None)

    rank_li_df_loss.to_csv(os.path.join(out_dir, 'loss_rank_li.csv'), index=None)
    rank_li_df_acc.to_csv(os.path.join(out_dir, 'acc_rank_li.csv'), index=None)
    rank_li_df_auc.to_csv(os.path.join(out_dir, 'auc_rank_li.csv'), index=None)

    logger.info(f'\nTotal time: {time.time() - begin:.3f}s')


def main(args):

    exp_dict = {'poison_frac': args.poison_frac, 'val_frac': args.val_frac}
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
    logger.info(f'timestamp: {datetime.now()}')

    process(args, exp_hash, out_dir, logger)


if __name__ == '__main__':
    main(summ_args.get_poison_args().parse_args())
