#!/bin/bash

tree_type_list=('lgb' 'sgb' 'xgb' 'cb')
ckpt_list=(1 2 3 4 5 6 7 8 9 10)

for tree_type in ${tree_type_list[@]}; do
    for ckpt in ${ckpt_list[@]}; do

        if [[ $exp = 'remove' ]]; then
            python3 scripts/summarize/remove_set.py --tree_type $tree_type --ckpt $ckpt

        elif [[ $exp = 'label' ]]; then
            python3 scripts/summarize/label_set.py --tree_type $tree_type --ckpt $ckpt

        elif [[ $exp = 'poison' ]]; then
            python3 scripts/summarize/poison_set.py --tree_type $tree_type --ckpt $ckpt

        fi

    done
done