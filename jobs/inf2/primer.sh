dataset=$1
tree_type=$2
method=$3
trunc_frac=$4
update_set=$5
leaf_scale=$6
inf_obj=$7
local_op=$8
global_op=$9
ncpu=${10}
time=${11}
partition=${12}

rs_list=(1 2 3 4 5)

if [ $inf_obj = 'global' ]
then
    inf_obj_list=('global')
elif [ $inf_obj =  'local' ]
then
    inf_obj_list=('local')
else
    inf_obj_list=('global' 'local')
fi

for inf_obj in ${inf_obj_list[@]}; do

    job_name=I2_${dataset}_${tree_type}_${method}_${inf_obj}_${local_op}_${global_op}

    sbatch --cpus-per-task=$ncpu \
           --time=$time \
           --partition=$partition \
           --job-name=$job_name \
           --output=jobs/logs/inf2/$job_name \
           --error=jobs/errors/inf2/$job_name \
           jobs/inf2/runner.sh $dataset $tree_type $method \
           $inf_obj $trunc_frac $update_set $leaf_scale $local_op $global_op

done