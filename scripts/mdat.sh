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
			mstd=$(
				awk '
				BEGIN{
					n = 0;
					m = 0;
					sqr = 0;
				}
				{
					m += $5;
					sqr += $5^2;
					n++;
				}
				END{
					m = m / n;
					std = sqrt( (sqr / n) - m^2);
					print m, " ", std
				}
				' $tFile
				)
			grep ${base}.bres -e "^$t $p " > $tFile
			mbWait=$(
				cut -f 5 -d ' ' $tFile |
				sort -nr |
				sed -e "1q"
				)
			mbstd=$(
				awk '
				BEGIN{
					n = 0;
					m = 0;
					sqr = 0;
				}
				{
					m += $5;
					sqr += $5^2;
					n++;
				}
				END{
					m = m / n;
					std = sqrt( (sqr / n) - m^2);
					print m, " ", std
				}
				' $tFile
				)
			echo $t $p $fps $mWait $mbWait $mstd $mbstd >> $rFile
		done
	done
	rm $tFile
done

