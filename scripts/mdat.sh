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
done

