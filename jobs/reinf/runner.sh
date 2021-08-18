#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --account=uoml
module load miniconda
conda activate jbrophy-20210713

dataset=$1
tree_type=$2
method=$3
inf_obj=$4
trunc_frac=$5
update_set=$6
leaf_scale=$7
local_op=$8
global_op=$9

python3 scripts/experiments/reinfluence.py \
  --dataset $dataset \
  --tree_type $tree_type \
  --method $method \
  --inf_obj $inf_obj \
  --trunc_frac $trunc_frac \
  --update_set $update_set \
  --leaf_scale $leaf_scale \
  --local_op $local_op \
  --global_op $global_op \