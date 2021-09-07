"""
Common commandline arguments.
"""
import configargparse


def get_general_args(cmd=None):
    """
    Create an ArgParser object and add general arguments to it.

    Return ArgParser object.
    """
    if cmd is None:
        cmd = configargparse.ArgParser(config_file_parser_class=configargparse.YAMLConfigFileParser)
    cmd.add('--data_dir', type=str, default='data/')
    cmd.add('--dataset', type=str, default='surgical')
    cmd.add('--tree_type', type=str, default='lgb')
    return cmd


def get_explainer_args(cmd=None):
    """
    Add arguments used by the explainers.

    Input
        cmd: ArgParser, object to add commandline arguments to.

    Return ArgParser object.
    """
    if cmd is None:
        cmd = configargparse.ArgParser(config_file_parser_class=configargparse.YAMLConfigFileParser)
    cmd.add('--method', type=str, default='random')
    cmd.add('--leaf_inf_update_set', type=int, default=0)  # LeafInfluence
    cmd.add('--input_sim_measure', type=str, default='euclidean')  # InputSim
    cmd.add('--tree_sim_measure', type=str, default='dot_prod')  # TreeSim
    cmd.add('--tree_kernel', type=str, default='lpw')  # Trex, TreeSim
    cmd.add('--trex_target', type=str, default='actual')  # Trex
    cmd.add('--trex_lmbd', type=float, default=0.003)  # Trex
    cmd.add('--trex_n_epoch', type=str, default=3000)  # Trex
    cmd.add('--dshap_trunc_frac', type=float, default=0.25)  # DShap
    cmd.add('--dshap_check_every', type=int, default=100)  # DShap
    cmd.add('--subsample_sub_frac', type=float, default=0.7)  # SubSample
    cmd.add('--subsample_n_iter', type=int, default=4000)  # SubSample
    cmd.add('--n_jobs', type=int, default=-1)  # LOO and DShap
    cmd.add('--random_state', type=int, default=1)  # DShap, LOO, Minority, Random, SubSample, Target, Trex
    return cmd


def get_influence_args():
    """
    Add arguments specific to the "Influence" experiment.

    Return ArgParser object.
    """
    cmd = get_general_args()
    cmd = get_explainer_args(cmd)
    cmd.add('--out_dir', type=str, default='output/influence/')
    cmd.add('--n_test', type=int, default=100)
    cmd.add('--remove_frac', type=float, default=0.02)
    cmd.add('--n_ckpt', type=int, default=20)
    return cmd


def get_counterfactual_args():
    """
    Add arguments specific to the "Counterfactual" experiment.

    Return ArgParser object.
    """
    cmd = get_general_args()
    cmd = get_explainer_args(cmd)
    cmd.add('--in_dir', type=str, default='temp_influence/')
    cmd.add('--out_dir', type=str, default='output/counterfactual/')
    cmd.add('--n_test', type=int, default=100)
    cmd.add('--remove_frac', type=float, default=0.02)
    cmd.add('--n_ckpt', type=int, default=20)
    cmd.add('--step_size', type=int, default=10)
    return cmd


def get_noise_args():
    """
    Add arguments specific to the "Noise" experiment.

    Return ArgParser object.
    """
    cmd = get_general_args()
    cmd = get_explainer_args(cmd)
    cmd.add('--out_dir', type=str, default='output/noise/')
    cmd.add('--strategy', type=str, default='test_sum')
    cmd.add('--noise_frac', type=float, default=0.2)
    cmd.add('--val_frac', type=float, default=0.1)
    cmd.add('--check_frac', type=float, default=0.1)
    cmd.add('--n_repeat', type=int, default=5)
    return cmd


def get_poison_args():
    """
    Add arguments specific to the "Poison" experiment.

    Return ArgParser object.
    """
    cmd = get_general_args()
    cmd = get_explainer_args(cmd)
    cmd.add('--out_dir', type=str, default='output/poison/')
    cmd.add('--poison_frac', type=float, nargs='+', default=[0.01, 0.05, 0.1, 0.2, 0.3])
    cmd.add('--val_frac', type=float, default=0.1)
    return cmd


def get_resources_args():
    """
    Add arguments specific to the "Resources" experiment.

    Return ArgParser object.
    """
    cmd = get_general_args()
    cmd = get_explainer_args(cmd)
    cmd.add('--out_dir', type=str, default='output/resources/')
    cmd.add('--n_repeat', type=int, default=5)
    cmd.add('--seed', type=int, default=-1)
    return cmd