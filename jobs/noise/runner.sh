#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --account=uoml
module load miniconda
conda activate jbrophy-20210713

dataset=$1
tree_type=$2
method=$3
trunc_frac=$4
update_set=$5
strategy=$6
noise_frac=$7

python3 scripts/experiments/noise.py \
  --dataset $dataset \
  --tree_type $tree_type \
  --method $method \
  --trunc_frac $trunc_frac \
  --update_set $update_set \
  --strategy $strategy \
  --noise_frac $noise_frac \