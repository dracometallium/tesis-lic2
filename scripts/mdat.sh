#!/bin/sh

arch=$1
dir=$(dirname $1)
base=$(basename -s .res $arch)
rFile=${dir}/${base}.dat
tFile=$(mktemp)

for t in $(seq 1 12); do
	for p in $(seq 1 24); do
		echo -n > $tFile
		grep $arch -e "^$t $p " > $tFile
		fps=$(
			cut -f 4 -d ' ' $tFile |
			sort -n |
			sed -e "1q"
		)
		grep ${dir}/${base}.bres -e "^$t $p " > $tFile
		mbWait=$(
			cut -f 5 -d ' ' $tFile |
			sort -nr |
			sed -e "1q"
			)
		echo $t $p $fps $mbWait >> $rFile
	done
done
rm $tFile

for j in $(cat $rFile | cut -f 3 -d ' '| sort | uniq); do
	cat $rFile | cut -f 3,4 -d ' ' | grep "^$j " | sort -k 2nr | sed '1q';
done > ${dir}/${base}.tdat
