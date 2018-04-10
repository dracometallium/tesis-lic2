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
set style line 1 lc rgb "#2222DD"
set boxwidth 0.75
set grid

set palette defined (0 '#2222DD', 1 '#AA2222')
unset colorbox

set output '/dev/null'
plot arch using 1:(floor($3/10))
maxy=floor((GPVAL_DATA_Y_MAX+50)/50)*50

set output dir.resolution.'_bestfps.pdf'
set title ""
set ylabel "Cuadros por segundo\n(retado en milisegundos)"
plot arch using 1:(floor($3/10)) with boxes ls 1 title '', \
 arch using 1:((floor($3/10))-maxy/20):\
 (sprintf('%.0f fps\n%.0f ms\n%d frg.', ($3/10.0), ($4*1000.0), $2))\
 with labels font ',8' textcolor '#FFFFAA' title ''

set yrange [0:*]
set ytics 0, 1

set output '/dev/null'
base=floor(base/10)
plot arch using 1:((floor($3/10)*1.0)/base)
maxy=(GPVAL_DATA_Y_MAX)

set output dir.resolution.'_speedup.pdf'
set ylabel "Speedup"
set label "■ Hilos de búsqueda\ncompartiendo unidades\nde procesamiento" at\
 0.5,(floor(maxy - 1)+1.75) tc rgb "#AA2222" 
plot arch using 1:((floor($3/10)*1.0)/base):(($1<7)?0:1) with boxes ls 1 palette z title '',\
 arch using 1:(((floor($3/10)*1.0)/base)-maxy/20):(sprintf('%.2fx', ((floor($3/10)*1.0)/base)))\
 with labels font ',8' textcolor '#FFFFAA' title ''
