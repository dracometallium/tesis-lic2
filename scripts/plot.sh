#!/bin/sh

for arch in *.dat; do
	dir=$(dirname $0)
	resolution=$(basename -s .dat $arch)
	gnuplot -e "arch='"$arch"';resolution='"$resolution"'" ${dir}/plot.gnuplot
done
