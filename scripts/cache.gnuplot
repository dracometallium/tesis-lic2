# vim: set syntax=gnuplot syntax :

set term pdfcairo font "Arial,12" dashed size 7,3
set linetype 1 lw 1 lc rgb "#D02720"  pointtype 7 ps 0.75
set linetype 2 lw 1 lc rgb "#1FD9B2" pointtype 11 ps 0.75
set linetype 3 lw 1 lc rgb "#3ADE58" pointtype 8 ps 0.75
set linetype 4 lw 1 lc rgb "#E0B82F" pointtype 10 ps 0.75
set linetype 5 lw 1 lc rgb "#A020F0" pointtype 12 ps 0.75
set linetype 6 lw 1 lc rgb "#825b4a" pointtype 13 ps 0.75
set linetype 7 lw 1 lc rgb "gray" pointtype 0
set grid xtics ytics lw 1 lc rgb 'gray'

set xlabel 'Nº hilos de búsqueda'

arch='img/cache.pdat'
set xrange [0.5:11.5]
set xtics 1

escala=1000000

set key outside
set ylabel "Millones de fallos caché por cuadro"
set output 'img/cache_fallos.pdf'
set title ""
plot arch using 1:($2/escala) with linespoints lt 1 title '1 fragmento', \
 arch using 1:($3/escala) with linespoints lt 2 title '2 fragmentos', \
 arch using 1:($4/escala) with linespoints lt 3 title '3 fragmentos', \
 arch using 1:($5/escala) with linespoints lt 4 title '4 fragmentos', \
 arch using 1:($7/escala) with linespoints lt 5 title '6 fragmentos', \
 arch using 1:($13/escala) with linespoints lt 6 title '12 fragmentos'
