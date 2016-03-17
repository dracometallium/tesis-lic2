#!/bin/sh

for arch in *.res; do
	dir=$(dirname $0)
	rFile=$(basename -s .res $arch).dat
	rm $rFile
	echo -n > $rFile
	tFile=$(mktemp)
	for t in $(seq 1 2 11); do
		for p in $(seq 1 24); do
			echo -n > $tFile
			grep $arch -e "^$t $p " > $tFile
			nItems=$(
				cut -f 3 -d ' ' $tFile |
				sort -n |
				sed -e "1d;9q" |
				awk '{s+=$1}END{print s/8}'
				)
			fps=$(
				cut -f 4 -d ' ' $tFile |
				sort -n |
				sed -e "1d;9q" |
				awk '{s+=$1}END{print s/8}'
			)
			mWait=$(
				cut -f 5 -d ' ' $tFile |
				sort -n |
				sed -e "1,+7d;9q"
				)
			tWait=$(
				cut -f 6 -d ' ' $tFile |
				sort -n |
				sed -e "1d;9q" |
				awk '{s+=$1}END{print s/8}'
				)
			echo $t $p $nItems $fps $mWait $tWait >> $rFile
		done
	done
	rm $tFile
done

