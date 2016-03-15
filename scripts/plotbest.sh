#!/bin/sh

for arch in *.dat; do
	dir=$(dirname $0)
	resolution=$(basename -s .dat $arch)
	barch=$(mktemp)
	for i in $(seq 1 2 11); do 
		grep $arch -e "^$i " | sort -k 4rn | sed 1q
	done > $barch
	gnuplot -e "arch='"$barch"';resolution='"$resolution"'" ${dir}/plotbest.gnuplot
	rm $barch
done
