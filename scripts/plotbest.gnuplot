# vim: set syntax=gnuplot :

#set style line 12 lc rgb '#808080' lt 0 lw 1
#set grid back ls 12

set term pdfcairo font "Arial,10"

set xrange [0.25:12.75]
set yrange [0:60 < *]
set xlabel "Nº hilos de búsqueda"
set xtics 1, 1
set ytics 0, 50
#set style line 1 lt 1 lw 10
set style fill solid 
set style line 1 lc rgb "#0000ff"
set boxwidth 0.75
set grid

set output '/dev/null'
plot arch using 1:($3/10)
maxy=GPVAL_DATA_Y_MAX

set output dir.resolution.'_bestfps.pdf'
set title ""
set ylabel "Cuadros por segundo\n(retado en milisegundos)"
plot arch using 1:($3/10) with boxes ls 1 title '', \
 arch using 1:($3/10)+((maxy-50)/12)*1.8:\
 (sprintf('%.0f fps\n%.0f ms\n%d frg.', ($3/10.0), ($4*1000.0), $2))\
 with labels font ',8' title ''
