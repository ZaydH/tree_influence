
exp='remove'
run=jobs/single_test/runner.sh
o=jobs/logs/${exp}/
t='lgb'

sbatch -a 1-21  -c 3  -t 1440 -p 'short' -o ${o}${t}'_random-%a.out'     $run $exp $t 'random'
sbatch -a 1-21  -c 3  -t 1440 -p 'short' -o ${o}${t}'_target-%a.out'     $run $exp $t 'target'
sbatch -a 1-21  -c 3  -t 1440 -p 'short' -o ${o}${t}'_input_sim-%a.out'  $run $exp $t 'input_sim'
sbatch -a 1-21  -c 3  -t 1440 -p 'short' -o ${o}${t}'_leaf_sim-%a.out'   $run $exp $t 'leaf_sim'
sbatch -a 1-21  -c 3  -t 1440 -p 'short' -o ${o}${t}'_boostin-%a.out'    $run $exp $t 'boostin'
sbatch -a 1-21  -c 3  -t 1440 -p 'short' -o ${o}${t}'_leaf_infSP-%a.out' $run $exp $t 'leaf_infSP'
sbatch -a 1-21  -c 9  -t 1440 -p 'short' -o ${o}${t}'_trex-%a.out'       $run $exp $t 'trex'
sbatch -a 1-21  -c 5  -t 1440 -p 'short' -o ${o}${t}'_subsample-%a.out'  $run $exp $t 'subsample'
sbatch -a 1-21  -c 5  -t 1440 -p 'short' -o ${o}${t}'_loo-%a.out'        $run $exp $t 'loo'
sbatch -a 3-6,8,10-13,16,18-19,21 -c 11 -t 1440 -p 'short' -o ${o}${t}'_leaf_inf-%a.out'   $run $exp $t 'leaf_inf'
sbatch -a 3-6,8,10-13,16,18-19,21 -c 11 -t 1440 -p 'short' -o ${o}${t}'_leaf_refit-%a.out' $run $exp $t 'leaf_refit'

sbatch -a 22 -c 20 -t 1440 -p 'short' -o ${o}${t}'_random-%a.out'     $run $exp $t 'random'
sbatch -a 22 -c 20 -t 1440 -p 'short' -o ${o}${t}'_target-%a.out'     $run $exp $t 'target'
sbatch -a 22 -c 11 -t 1440 -p 'short' -o ${o}${t}'_input_sim-%a.out'  $run $exp $t 'input_sim'
sbatch -a 22 -c 11 -t 1440 -p 'short' -o ${o}${t}'_leaf_sim-%a.out'   $run $exp $t 'leaf_sim'
sbatch -a 22 -c 11 -t 1440 -p 'short' -o ${o}${t}'_boostin-%a.out'    $run $exp $t 'boostin'
sbatch -a 22 -c 11 -t 1440 -p 'short' -o ${o}${t}'_leaf_infSP-%a.out' $run $exp $t 'leaf_infSP'
sbatch -a 22 -c 28 -t 1440 -p 'short' -o ${o}${t}'_trex-%a.out'       $run $exp $t 'trex'
sbatch -a 22 -c 28 -t 1440 -p 'short' -o ${o}${t}'_subsample-%a.out'  $run $exp $t 'subsample'
sbatch -a 22 -c 28 -t 1440 -p 'short' -o ${o}${t}'_loo-%a.out'        $run $exp $t 'loo'

# xgb only

# sgb only

# cb only

# scratch pad