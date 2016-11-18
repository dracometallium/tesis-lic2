#!/bin/sh

	arch=$1
	dir=$(dirname $1)
	resolution=$(basename -s .dat $arch)
	gnuplot -e "arch='"$arch"';resolution='"$resolution"';dir='"$dir/"';" scripts/plot.gnuplot
