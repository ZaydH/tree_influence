tt='lgb'

dad='adult'
dbm='bank_marketing'
dbn='bean'
dco='compas'
dcn='concrete'
dcc='credit_card'
ddb='diabetes'
den='energy'
dfd='flight_delays'
dgc='german_credit'
dht='htru2'
dlf='life'
dnv='naval'
dns='no_show'
dms='msd'
dob='obesity'
dpw='power'
dpr='protein'
dsb='spambase'
dsg='surgical'
dtw='twitter'
dvc='vaccine'
dwn='wine'

mr='random'
mm='minority'
mbi='boostin'
mb2='boostin2'
mb3='boostin3'
mb4='boostin4'
mtx='trex'
mli='leaf_influence'
mlo='loo'
mds='dshap'
ms='similarity'
ml='loss'
mtg='target'
msb='subsampleB'

ps='short'
pl='long'

tf=0.25  # trunc_frac

us0=0  # leaf_influence update set
us1=-1

sc0=0.0 # boostin leaf_scale
sc1=-1.0
sc2=-2.0
sc3=-3.0

iog='global'  # inf_obj
iol='local'
iob='both'

lno='normal'  # local_op, boostin
lsg='sign'  # boostin
lsr='sign_tr'  # boostin
lse='sign_te'  # boostin

gos='self'  # global_op
goe='expected'  # TREX, LOO, and DShap
goa='alpha'  # TREX only

# adult
./jobs/cf/primer.sh     $dad $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dad $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dad $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dad $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dad $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dad $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dad $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dad $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dad $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dad $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dad $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dad $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dad $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dad $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dad $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dad $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
# ./jobs/cf/primer.sh     $dad $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  10080 $p2  # leaf_influence
./jobs/cf/primer.sh     $dad $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dad $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dad $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dad $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dad $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 1440  $ps  # dshap
# ./jobs/cf/primer.sh $dad $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 1440  $ps

# bank_marketing
./jobs/cf/primer.sh     $dbm $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dbm $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dbm $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dbm $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dbm $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dbm $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dbm $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dbm $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dbm $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dbm $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dbm $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dbm $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dbm $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dbm $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dbm $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dbm $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
# ./jobs/cf/primer.sh     $dbm $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  600 $p2  # leaf_influence
./jobs/cf/primer.sh     $dbm $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dbm $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dbm $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dbm $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dbm $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $dbm $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# bean
./jobs/cf/primer.sh     $dbn $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dbn $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dbn $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dbn $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dbn $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dbn $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dbn $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dbn $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dbn $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dbn $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dbn $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dbn $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dbn $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dbn $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dbn $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dbn $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
# ./jobs/cf/primer.sh     $dbn $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  600 $p2  # leaf_influence
./jobs/cf/primer.sh     $dbn $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dbn $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dbn $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dbn $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dbn $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $dbn $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# compas
./jobs/cf/primer.sh     $dco $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dco $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dco $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dco $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dco $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dco $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dco $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dco $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dco $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dco $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dco $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dco $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dco $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dco $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dco $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dco $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
./jobs/cf/primer.sh     $dco $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # leaf_influence
./jobs/cf/primer.sh     $dco $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dco $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dco $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dco $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dco $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $dco $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# concrete
./jobs/cf/primer.sh     $dcn $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dcn $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dcn $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dcn $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dcn $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dcn $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dcn $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dcn $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dcn $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dcn $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dcn $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dcn $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dcn $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dcn $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dcn $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dcn $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
./jobs/cf/primer.sh     $dcn $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # leaf_influence
./jobs/cf/primer.sh     $dcn $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dcn $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dcn $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dcn $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dcn $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $dcn $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# credit_card
./jobs/cf/primer.sh     $dcc $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dcc $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dcc $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dcc $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dcc $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dcc $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dcc $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dcc $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dcc $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dcc $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dcc $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dcc $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dcc $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dcc $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dcc $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dcc $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
# ./jobs/cf/primer.sh     $dcc $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  600 $p2  # leaf_influence
./jobs/cf/primer.sh     $dcc $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dcc $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dcc $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dcc $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dcc $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $dcc $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# diabetes
./jobs/cf/primer.sh     $ddb $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  1440    $ps  # random
# ./jobs/cf/primer.sh     $ddb $tt $mm  $tf $us1 $iol $lno $gos 3  1440    $ps  # minority
./jobs/cf/primer.sh     $ddb $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  1440    $ps  # target
./jobs/cf/primer.sh     $ddb $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  1440    $ps  # similarity
# ./jobs/cf/primer.sh     $ddb $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  1440    $ps  # boostin
# ./jobs/cf/primer.sh     $ddb $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  1440    $ps
# ./jobs/cf/primer.sh     $ddb $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  1440    $ps
# ./jobs/cf/primer.sh     $ddb $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  1440    $ps
# ./jobs/cf/primer.sh     $ddb $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  1440    $ps
# ./jobs/cf/primer.sh     $ddb $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  1440    $ps
./jobs/cf/primer.sh     $ddb $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  1440    $ps  # boostin2
# ./jobs/cf/primer.sh     $ddb $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  1440    $ps  # boostin3
# ./jobs/cf/primer.sh     $ddb $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  1440    $ps  # boostin4
./jobs/cf/primer.sh     $ddb $tt $mtx $tf $us1 $sc1 $iol $lno $gos 9  1440    $ps  # trex
# ./jobs/cf/primer.sh     $ddb $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  1440    $ps
# ./jobs/cf/primer.sh     $ddb $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  1440    $ps
# ./jobs/cf/primer.sh     $ddb $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  10080 $p2  # leaf_influence
./jobs/cf/primer.sh     $ddb $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  1440  $ps
./jobs/cf/primer.sh     $ddb $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  1440  $ps  # loo
# ./jobs/cf/primer.sh $ddb $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 1440   $ps
./jobs/cf/primer.sh     $ddb $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  1440  $ps  # subsample
# ./jobs/cf/primer.sh $ddb $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 1440  $ps  # dshap
# ./jobs/cf/primer.sh $ddb $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 1440  $ps

# energy
./jobs/cf/primer.sh     $den $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $den $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $den $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $den $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $den $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $den $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $den $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $den $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $den $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $den $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $den $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $den $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $den $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $den $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $den $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $den $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
./jobs/cf/primer.sh     $den $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # leaf_influence
./jobs/cf/primer.sh     $den $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $den $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $den $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $den $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $den $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $den $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# flight_delays
./jobs/cf/primer.sh     $dfd $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  1440    $ps  # random
# ./jobs/cf/primer.sh     $dfd $tt $mm  $tf $us1 $iol $lno $gos 3  1440    $ps  # minority
./jobs/cf/primer.sh     $dfd $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  1440    $ps  # target
./jobs/cf/primer.sh     $dfd $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  1440    $ps  # similarity
# ./jobs/cf/primer.sh     $dfd $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  1440    $ps  # boostin
# ./jobs/cf/primer.sh     $dfd $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  1440    $ps
# ./jobs/cf/primer.sh     $dfd $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  1440    $ps
# ./jobs/cf/primer.sh     $dfd $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  1440    $ps
# ./jobs/cf/primer.sh     $dfd $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  1440    $ps
# ./jobs/cf/primer.sh     $dfd $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  1440    $ps
./jobs/cf/primer.sh     $dfd $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  1440    $ps  # boostin2
# ./jobs/cf/primer.sh     $dfd $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  1440    $ps  # boostin3
# ./jobs/cf/primer.sh     $dfd $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  1440    $ps  # boostin4
./jobs/cf/primer.sh     $dfd $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  1440    $ps  # trex
# ./jobs/cf/primer.sh     $dfd $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  1440    $ps
# ./jobs/cf/primer.sh     $dfd $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  1440    $ps
# ./jobs/cf/primer.sh     $dfd $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  10080 $p2  # leaf_influence
./jobs/cf/primer.sh     $dfd $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  1440  $ps
./jobs/cf/primer.sh     $dfd $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  1440  $ps  # loo
# ./jobs/cf/primer.sh $dfd $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 1440   $ps
./jobs/cf/primer.sh     $dfd $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  1440  $ps  # subsample
# ./jobs/cf/primer.sh $dfd $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 1440  $ps  # dshap
# ./jobs/cf/primer.sh $dfd $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 1440  $ps

# german_credit
./jobs/cf/primer.sh     $dgc $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dgc $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dgc $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dgc $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dgc $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dgc $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dgc $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dgc $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dgc $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dgc $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dgc $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dgc $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dgc $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dgc $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dgc $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dgc $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
./jobs/cf/primer.sh     $dgc $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # leaf_influence
./jobs/cf/primer.sh     $dgc $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dgc $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dgc $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dgc $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dgc $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $dgc $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# htru2
./jobs/cf/primer.sh     $dht $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dht $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dht $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dht $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dht $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dht $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dht $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dht $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dht $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dht $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dht $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dht $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dht $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dht $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dht $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dht $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
# ./jobs/cf/primer.sh     $dht $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  600 $p2  # leaf_influence
./jobs/cf/primer.sh     $dht $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dht $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dht $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dht $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dht $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $dht $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# life
./jobs/cf/primer.sh     $dlf $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dlf $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dlf $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dlf $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dlf $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dlf $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dlf $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dlf $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dlf $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dlf $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dlf $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dlf $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dlf $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dlf $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dlf $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dlf $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
./jobs/cf/primer.sh     $dlf $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # leaf_influence
./jobs/cf/primer.sh     $dlf $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dlf $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dlf $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dlf $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dlf $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $dlf $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# msd
./jobs/cf/primer.sh     $dms $tt $mr  $tf $us1 $sc1 $iol $lno $gos 20  1440    $ps  # random
# ./jobs/cf/primer.sh     $dms $tt $mm  $tf $us1 $iol $lno $gos 20  1440    $ps  # minority
./jobs/cf/primer.sh     $dms $tt $mtg $tf $us1 $sc1 $iol $lno $gos 20  1440    $ps  # target
./jobs/cf/primer.sh     $dms $tt $ms  $tf $us1 $sc1 $iol $lno $gos 20  1440    $ps  # similarity
# ./jobs/cf/primer.sh     $dms $tt $mbi $tf $us1 $sc0 $iol $lno $gos 20  1440    $ps  # boostin
# ./jobs/cf/primer.sh     $dms $tt $mbi $tf $us1 $sc1 $iol $lno $gos 20  1440    $ps
# ./jobs/cf/primer.sh     $dms $tt $mbi $tf $us1 $sc2 $iol $lno $gos 20  1440    $ps
# ./jobs/cf/primer.sh     $dms $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 20  1440    $ps
# ./jobs/cf/primer.sh     $dms $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 20  1440    $ps
# ./jobs/cf/primer.sh     $dms $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 20  1440    $ps
./jobs/cf/primer.sh     $dms $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 20  1440    $ps  # boostin2
# ./jobs/cf/primer.sh     $dms $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 20  1440    $ps  # boostin3
# ./jobs/cf/primer.sh     $dms $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 20  1440    $ps  # boostin4
./jobs/cf/primer.sh     $dms $tt $mtx $tf $us1 $sc1 $iol $lno $gos 20  1440    $ps  # trex
# ./jobs/cf/primer.sh     $dms $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  1440    $ps
# ./jobs/cf/primer.sh     $dms $tt $mtx $tf $us1 $sc1 $iol $lno $goa 20  1440    $ps
./jobs/cf/primer.sh     $dms $tt $mli $tf $us1 $sc1 $iol $lno $gos 20  1440  $ps  # leaf_influence
./jobs/cf/primer.sh     $dms $tt $mli $tf $us0 $sc1 $iol $lno $gos 20  1440  $ps
./jobs/cf/primer.sh     $dms $tt $mlo $tf $us1 $sc1 $iol $lno $gos 20  1440  $ps  # loo
# ./jobs/cf/primer.sh $dms $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 1440   $ps
./jobs/cf/primer.sh     $dms $tt $msb $tf $us1 $sc1 $iol $lno $gos 20  1440  $ps  # subsample
# ./jobs/cf/primer.sh $dms $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 1440  $ps  # dshap
# ./jobs/cf/primer.sh $dms $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 1440  $ps

# naval
./jobs/cf/primer.sh     $dnv $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dnv $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dnv $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dnv $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dnv $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dnv $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dnv $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dnv $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dnv $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dnv $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dnv $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dnv $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dnv $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dnv $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dnv $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dnv $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
./jobs/cf/primer.sh     $dnv $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # leaf_influence
./jobs/cf/primer.sh     $dnv $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dnv $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dnv $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dnv $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dnv $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $dnv $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# no_show
./jobs/cf/primer.sh     $dns $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dns $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dns $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dns $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dns $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dns $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dns $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dns $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dns $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dns $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dns $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dns $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dns $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dns $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dns $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dns $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
# ./jobs/cf/primer.sh     $dns $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  600 $p2  # leaf_influence
./jobs/cf/primer.sh     $dns $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dns $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dns $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dns $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dns $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $dns $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# obesity
./jobs/cf/primer.sh     $dob $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dob $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dob $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dob $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dob $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dob $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dob $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dob $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dob $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dob $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dob $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dob $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dob $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dob $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dob $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dob $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
# ./jobs/cf/primer.sh     $dob $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  600 $p2  # leaf_influence
./jobs/cf/primer.sh     $dob $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dob $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dob $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dob $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dob $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $dob $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# power
./jobs/cf/primer.sh     $dpw $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dpw $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dpw $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dpw $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dpw $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dpw $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dpw $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dpw $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dpw $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dpw $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dpw $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dpw $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dpw $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dpw $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dpw $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dpw $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
./jobs/cf/primer.sh     $dpw $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # leaf_influence
./jobs/cf/primer.sh     $dpw $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dpw $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dpw $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dpw $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dpw $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $dpw $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# protein
./jobs/cf/primer.sh     $dpr $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  1440    $ps  # random
# ./jobs/cf/primer.sh     $dpr $tt $mm  $tf $us1 $iol $lno $gos 3  1440    $ps  # minority
./jobs/cf/primer.sh     $dpr $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  1440    $ps  # target
./jobs/cf/primer.sh     $dpr $tt $ms  $tf $us1 $sc1 $iol $lno $gos 5  1440    $ps  # similarity
# ./jobs/cf/primer.sh     $dpr $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  1440    $ps  # boostin
# ./jobs/cf/primer.sh     $dpr $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  1440    $ps
# ./jobs/cf/primer.sh     $dpr $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  1440    $ps
# ./jobs/cf/primer.sh     $dpr $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  1440    $ps
# ./jobs/cf/primer.sh     $dpr $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  1440    $ps
# ./jobs/cf/primer.sh     $dpr $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  1440    $ps
./jobs/cf/primer.sh     $dpr $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  1440    $ps  # boostin2
# ./jobs/cf/primer.sh     $dpr $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  1440    $ps  # boostin3
# ./jobs/cf/primer.sh     $dpr $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  1440    $ps  # boostin4
./jobs/cf/primer.sh     $dpr $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  1440    $ps  # trex
# ./jobs/cf/primer.sh     $dpr $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  1440    $ps
# ./jobs/cf/primer.sh     $dpr $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  1440    $ps
# ./jobs/cf/primer.sh     $dpr $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  10080 $p2  # leaf_influence
./jobs/cf/primer.sh     $dpr $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  1440  $ps
./jobs/cf/primer.sh     $dpr $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  1440  $ps  # loo
# ./jobs/cf/primer.sh $dpr $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 1440   $ps
./jobs/cf/primer.sh     $dpr $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  1440  $ps  # subsample
# ./jobs/cf/primer.sh $dpr $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 1440  $ps  # dshap
# ./jobs/cf/primer.sh $dpr $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 1440  $ps

# spambase
./jobs/cf/primer.sh     $dsb $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dsb $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dsb $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dsb $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dsb $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dsb $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dsb $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dsb $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dsb $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dsb $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dsb $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dsb $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dsb $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dsb $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dsb $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dsb $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
./jobs/cf/primer.sh     $dsb $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  600  $pl  # leaf_influence
./jobs/cf/primer.sh     $dsb $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dsb $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer_mcu.sh $dsb $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dsb $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer_mcu.sh $dsb $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer_mcu.sh $dsb $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# surgical
./jobs/cf/primer.sh     $dsg $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dsg $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dsg $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dsg $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dsg $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dsg $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dsg $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dsg $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dsg $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dsg $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dsg $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dsg $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dsg $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dsg $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dsg $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dsg $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
# ./jobs/cf/primer.sh     $dsg $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  10080 $p2  # leaf_influence
./jobs/cf/primer.sh     $dsg $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dsg $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dsg $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dsg $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dsg $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $dsg $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# twitter
./jobs/cf/primer.sh     $dtw $tt $mr  $tf $us1 $sc1 $iol $lno $gos 11  1440    $ps  # random
# ./jobs/cf/primer.sh     $dtw $tt $mm  $tf $us1 $iol $lno $gos 3  1440    $ps  # minority
./jobs/cf/primer.sh     $dtw $tt $mtg $tf $us1 $sc1 $iol $lno $gos 11  1440    $ps  # target
./jobs/cf/primer.sh     $dtw $tt $ms  $tf $us1 $sc1 $iol $lno $gos 11  1440    $ps  # similarity
# ./jobs/cf/primer.sh     $dtw $tt $mbi $tf $us1 $sc0 $iol $lno $gos 11  1440    $ps  # boostin
# ./jobs/cf/primer.sh     $dtw $tt $mbi $tf $us1 $sc1 $iol $lno $gos 11  1440    $ps
# ./jobs/cf/primer.sh     $dtw $tt $mbi $tf $us1 $sc2 $iol $lno $gos 11  1440    $ps
# ./jobs/cf/primer.sh     $dtw $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 11  1440    $ps
# ./jobs/cf/primer.sh     $dtw $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 11  1440    $ps
# ./jobs/cf/primer.sh     $dtw $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 11  1440    $ps
./jobs/cf/primer.sh     $dtw $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 11  1440    $ps  # boostin2
# ./jobs/cf/primer.sh     $dtw $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 11  1440    $ps  # boostin3
# ./jobs/cf/primer.sh     $dtw $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 11  1440    $ps  # boostin4
./jobs/cf/primer.sh     $dtw $tt $mtx $tf $us1 $sc1 $iol $lno $gos 11  1440    $ps  # trex
# ./jobs/cf/primer.sh     $dtw $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dtw $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
# ./jobs/cf/primer.sh     $dtw $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  10080 $p2  # leaf_influence
./jobs/cf/primer.sh     $dtw $tt $mli $tf $us0 $sc1 $iol $lno $gos 11  1440    $ps
./jobs/cf/primer.sh     $dtw $tt $mlo $tf $us1 $sc1 $iol $lno $gos 11  1440    $ps  # loo
# ./jobs/cf/primer.sh $dtw $tt $mlo $tf $us1 $sc1 $iol $lno $goe 11 600   $ps
./jobs/cf/primer.sh     $dtw $tt $msb $tf $us1 $sc1 $iol $lno $gos 11  1440    $ps  # subsample
# ./jobs/cf/primer.sh $dtw $tt $mds $tf $us1 $sc1 $iol $lno $gos 11 1440  $ps  # dshap
# ./jobs/cf/primer.sh $dtw $tt $mds $tf $us1 $sc1 $iol $lno $goe 11 1440  $ps

# vaccine
./jobs/cf/primer.sh     $dvc $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dvc $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dvc $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dvc $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dvc $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dvc $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dvc $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dvc $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dvc $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dvc $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dvc $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dvc $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dvc $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dvc $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dvc $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dvc $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
# ./jobs/cf/primer.sh     $dvc $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  10080 $p2  # leaf_influence
./jobs/cf/primer.sh     $dvc $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dvc $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dvc $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dvc $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dvc $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $dvc $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps

# wine
./jobs/cf/primer.sh     $dwn $tt $mr  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # random
# ./jobs/cf/primer.sh     $dwn $tt $mm  $tf $us1 $iol $lno $gos 3  600    $ps  # minority
./jobs/cf/primer.sh     $dwn $tt $mtg $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # target
./jobs/cf/primer.sh     $dwn $tt $ms  $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # similarity
# ./jobs/cf/primer.sh     $dwn $tt $mbi $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin
# ./jobs/cf/primer.sh     $dwn $tt $mbi $tf $us1 $sc1 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dwn $tt $mbi $tf $us1 $sc2 $iol $lno $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dwn $tt $mbi $tf $us1 $sc0 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dwn $tt $mbi $tf $us1 $sc1 $iol $lsg $gos 3  600    $ps
# ./jobs/cf/primer.sh     $dwn $tt $mbi $tf $us1 $sc2 $iol $lsg $gos 3  600    $ps
./jobs/cf/primer.sh     $dwn $tt $mb2 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin2
# ./jobs/cf/primer.sh     $dwn $tt $mb3 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin3
# ./jobs/cf/primer.sh     $dwn $tt $mb4 $tf $us1 $sc0 $iol $lno $gos 3  600    $ps  # boostin4
./jobs/cf/primer.sh     $dwn $tt $mtx $tf $us1 $sc1 $iol $lno $gos 3  600    $ps  # trex
# ./jobs/cf/primer.sh     $dwn $tt $mtx $tf $us1 $sc1 $iol $lno $goe 6  600    $ps
# ./jobs/cf/primer.sh     $dwn $tt $mtx $tf $us1 $sc1 $iol $lno $goa 3  600    $ps
./jobs/cf/primer.sh     $dwn $tt $mli $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # leaf_influence
./jobs/cf/primer.sh     $dwn $tt $mli $tf $us0 $sc1 $iol $lno $gos 3  600  $ps
./jobs/cf/primer.sh     $dwn $tt $mlo $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # loo
# ./jobs/cf/primer.sh $dwn $tt $mlo $tf $us1 $sc1 $iol $lno $goe 28 600   $ps
./jobs/cf/primer.sh     $dwn $tt $msb $tf $us1 $sc1 $iol $lno $gos 3  600  $ps  # subsample
# ./jobs/cf/primer.sh $dwn $tt $mds $tf $us1 $sc1 $iol $lno $gos 28 600  $ps  # dshap
# ./jobs/cf/primer.sh $dwn $tt $mds $tf $us1 $sc1 $iol $lno $goe 28 600  $ps