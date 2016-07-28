#!/bin/sh
awkProg='
	BEGIN{
		n = 0;
		m = 0;
		sqr = 0;
		err = 0.05;
	}
	{
		m += $5;
		sqr += $5^2;
		n++;
	}
	END{
		m = m / n;
		var = ((sqr / n) - m^2);
		std = sqrt(var);
		l = m + sqrt( (var / err) - var );
		print l
	}
'

bkIFS=$IFS
for arch in *.res; do
	dir=$(dirname $0)
	base=$(basename -s .res $arch)
	rFile=${base}.dat
	echo -n > $rFile
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
			mWait=$(
				cut -f 5 -d ' ' $tFile |
				sort -nr |
				sed -e "1q"
				)
			err=$(
				awk "$awkProg" $tFile
				)
			grep ${base}.bres -e "^$t $p " > $tFile
			mbWait=$(
				cut -f 5 -d ' ' $tFile |
				sort -nr |
				sed -e "1q"
				)
			berr=$(
				awk "$awkProg" $tFile
				)
			echo $t $p $fps $mWait $mbWait $err $berr >> $rFile
		done
	done
	rm $tFile
	echo $rFile
	IFS=$(printf "\n\t")
	for j in $(seq 1 2000); do
		cat $rFile | cut -f 3,4 -d ' ' | grep "^$j " | sort -k 2nr | sed '1q';
	done > ${base}.tdat
	IFS=$bkIFS
done

