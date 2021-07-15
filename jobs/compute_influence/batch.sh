./jobs/compute_influence/primer.sh 'adult' 'lgb' 200 5 'random'         3  60    'short'
./jobs/compute_influence/primer.sh 'adult' 'lgb' 200 5 'boostin'        3  60    'short'
./jobs/compute_influence/primer.sh 'adult' 'lgb' 200 5 'trex'           3  60    'short'
./jobs/compute_influence/primer.sh 'adult' 'lgb' 200 5 'leaf_influence' 7  10080 'short'
./jobs/compute_influence/primer.sh 'adult' 'lgb' 200 5 'loo'            7  600   'short'

./jobs/compute_influence/primer.sh 'bank_marketing' 'lgb' 50 5 'random'         3  60   'short'
./jobs/compute_influence/primer.sh 'bank_marketing' 'lgb' 50 5 'boostin'        3  60   'short'
./jobs/compute_influence/primer.sh 'bank_marketing' 'lgb' 50 5 'trex'           3  60   'short'
./jobs/compute_influence/primer.sh 'bank_marketing' 'lgb' 50 5 'leaf_influence' 7  2880 'long'
./jobs/compute_influence/primer.sh 'bank_marketing' 'lgb' 50 5 'loo'            7  600  'short'

./jobs/compute_influence/primer.sh 'surgical' 'lgb' 50 7 'random'         3  60  'short'
./jobs/compute_influence/primer.sh 'surgical' 'lgb' 50 7 'boostin'        3  60  'short'
./jobs/compute_influence/primer.sh 'surgical' 'lgb' 50 7 'trex'           3  60  'short'
./jobs/compute_influence/primer.sh 'surgical' 'lgb' 50 7 'leaf_influence' 7  600 'short'
./jobs/compute_influence/primer.sh 'surgical' 'lgb' 50 7 'loo'            7  600 'short'
./jobs/compute_influence/primer_multi_cpu.sh 'surgical' 'lgb' 50 7 'dshap'         0.5  28  1440 'short'
./jobs/compute_influence/primer_multi_cpu.sh 'surgical' 'lgb' 50 7 'dshap'         0.75 28  1440 'short'

./jobs/compute_influence/primer.sh 'vaccine' 'lgb' 200 3 'random'         3  60   'short'
./jobs/compute_influence/primer.sh 'vaccine' 'lgb' 200 3 'boostin'        3  60   'short'
./jobs/compute_influence/primer.sh 'vaccine' 'lgb' 200 3 'trex'           3  60   'short'
./jobs/compute_influence/primer.sh 'vaccine' 'lgb' 200 3 'leaf_influence' 7  4320 'short'
./jobs/compute_influence/primer.sh 'vaccine' 'lgb' 200 3 'loo'            7  600  'short'

./jobs/compute_influence/primer.sh 'synth_binary' 'lgb' 100 7 'random'         7  60  'short'
./jobs/compute_influence/primer.sh 'synth_binary' 'lgb' 100 7 'boostin'        7  60  'short'
./jobs/compute_influence/primer.sh 'synth_binary' 'lgb' 100 7 'trex'           7  60  'short'
./jobs/compute_influence/primer.sh 'synth_binary' 'lgb' 100 7 'leaf_influence' 7  300 'short'
./jobs/compute_influence/primer.sh 'synth_binary' 'lgb' 100 7 'loo'            7  300 'short'

./jobs/compute_influence/primer.sh 'synth_regression' 'lgb' 10 2 'random'         3  60  'short'
./jobs/compute_influence/primer.sh 'synth_regression' 'lgb' 10 2 'boostin'        3  60  'short'
./jobs/compute_influence/primer.sh 'synth_regression' 'lgb' 10 2 'trex'           3  60  'short'
./jobs/compute_influence/primer.sh 'synth_regression' 'lgb' 10 2 'leaf_influence' 7  300 'short'
./jobs/compute_influence/primer.sh 'synth_regression' 'lgb' 10 2 'loo'            7  300 'short'

./jobs/compute_influence/primer.sh 'synth_multiclass' 'lgb' 200 7 'random'         7  60   'short'
./jobs/compute_influence/primer.sh 'synth_multiclass' 'lgb' 200 7 'boostin'        7  60   'short'
./jobs/compute_influence/primer.sh 'synth_multiclass' 'lgb' 200 7 'trex'           7  60   'short'
./jobs/compute_influence/primer.sh 'synth_multiclass' 'lgb' 200 7 'leaf_influence' 7  1880 'short'
./jobs/compute_influence/primer.sh 'synth_multiclass' 'lgb' 200 7 'loo'            7  300  'short'