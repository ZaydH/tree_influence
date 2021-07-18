"""
Display resource use for each experiment.
"""
import os
import sys
import argparse
import datetime

import numpy as np

here = os.path.abspath(os.path.dirname(__file__))
sys.path.insert(0, here + '/../')
from experiments import util


def get_result(in_dir, logger):
    """
    Recursively find all result files and display
    the memory usage and time elapsed.
    """

    for name in os.listdir(in_dir):
        fp = os.path.join(in_dir, name)

        if os.path.isdir(fp):
            get_result(fp, logger)

        elif name == 'results.npy':
            res = np.load(fp, allow_pickle=True)[()]
            mem = res['max_rss_MB']
            time_str = datetime.timedelta(seconds=res['compute_time'])

            logger.info(f'{fp:<110}: {mem:>5.1f} GB, {time_str}s')


def main(args):

    # create output dir
    out_dir = os.path.join(args.out_dir)

    # create output directory and clear previous contents
    os.makedirs(out_dir, exist_ok=True)

    logger = util.get_logger(os.path.join(out_dir, 'log.txt'))
    logger.info(args)
    logger.info(f'\ntimestamp: {datetime.datetime.now()}')
    logger.info('\n[NOTE] Memory is MB if results are from OSX, GB if Linux\n')

    get_result(args.in_dir, logger)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--in_dir', type=str, default='output/influence/')
    parser.add_argument('--out_dir', type=str, default='output/resource_usage/')
    args = parser.parse_args()
    main(args)