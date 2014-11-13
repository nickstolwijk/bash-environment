#!/bin/sh
 
for h in wendy wanda wilma wilga willy weena wiske woopy
do
   wget -q http://sander:ajax33@${h}stats.ecom.ahold.nl/$1 -O ${h}.log &
done
