#!/bin/bash

tree_type_list=('lgb' 'sgb' 'xgb' 'cb')
ckpt_list=(1 2 3 4 5 6 7 8 9 10)

for tree_type in ${tree_type_list[@]}; do
    for ckpt in ${ckpt_list[@]}; do
        python3 scripts/summarize/removal_set.py --tree_type $tree_type --ckpt $ckpt
    done
done