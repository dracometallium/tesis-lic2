# vim: set syntax=gnuplot :

#set style line 12 lc rgb '#808080' lt 0 lw 1
#set grid back ls 12

set term pdfcairo font "Arial,10"

set xrange [0.25:12.75]
set yrange [0:60 < *]
set xlabel "Nº hilos de búsqueda"
set xtics 1, 1
#set style line 1 lt 1 lw 10
set style fill solid 
set style line 1 lc rgb "#0000ff"
set boxwidth 0.75
set grid

set output dir.resolution.'_bestfps.pdf'
set title ""
set ylabel "Cuadros por segundo\n(retado en milisegundos)"
plot arch using 1:($3/10) with boxes ls 1 title '', \
 arch using 1:($3/10)+6:(sprintf('%.0ffps', ($3/10.0))) with labels font ',8' title '', \
 arch using 1:($3/10)+2:(sprintf('(%.1fms)', ($4*1000.0))) with labels font ',8' title ''
