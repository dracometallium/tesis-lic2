#!/bin/sh

arch=$1
dir=$(dirname $1)
resolution=$(basename -s .dat $arch)
barch=$(mktemp)
for i in $(seq 1 1 12); do 
	grep $arch -e "^$i " | sort -k 3rn | sed 1q
done > $barch
base=$(head -1 "$barch" | awk '{print $3}')
gnuplot -e "arch='"$barch"';resolution='"$resolution"';dir='"${dir}"/';base='"$base"'" scripts/plotbest.gnuplot
rm $barch
