( 
for val in 80 85 90 95 100 105 110 115;
do
  sed -i  "s/static int cc_delay_mult=.*/static int cc_delay_mult=$val;/" CCDebugger.c
  make > /dev/null
  echo "$val -> `./cc_chipid` `./cc_chipid`  `./cc_chipid`  `./cc_chipid`" 
done 
) | grep 'b524'

