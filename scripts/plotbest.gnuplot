# vim: set syntax=gnuplot syntax :

#set style line 12 lc rgb '#808080' lt 0 lw 1
#set grid back ls 12

set term pdfcairo font "Arial,10"

set xrange [0.5:13.5]
set yrange [0:65]
set xlabel "Nº Procesadores\n(Nº threads búsqueda + 1)"
set xtics 2, 2
#set style line 1 lt 1 lw 10
set style fill solid 
set style line 1 lc rgb "#0000ff"
set boxwidth 1.5
set grid

set output resolution.'_bestfps.pdf'
set title "Cuadros por segundo\n".resolution." pixeles"
set ylabel 'Cuadros por segundo'
plot arch using ($1+1):($4/10) with boxes ls 1 title '', \
 arch using ($1+1):($4/10)+2:(sprintf('%.1f', ($4/10.0))) with labels font ',10' title ''
