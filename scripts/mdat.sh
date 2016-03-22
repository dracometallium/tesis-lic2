#!/bin/sh

for arch in *.res; do
	dir=$(dirname $0)
	base=$(basename -s .res $arch)
	rFile=${base}.dat
	echo -n > $rFile
	tFile=$(mktemp)
	for t in $(seq 1 2 11); do
		for p in $(seq 1 24); do
			echo -n > $tFile
			grep $arch -e "^$t $p " > $tFile
			fps=$(
				cut -f 4 -d ' ' $tFile |
				sort -n |
				sed -e "1q"
			)
			mWait=$(
				cut -f 5 -d ' ' $tFile |
				sort -nr |
				sed -e "1q"
				)
			grep ${base}.bres -e "^$t $p " > $tFile
			mbWait=$(
				cut -f 5 -d ' ' $tFile |
				sort -nr |
				sed -e "1q"
				)
			echo $t $p $fps $mWait $mbWait >> $rFile
		done
	done
	rm $tFile
done

