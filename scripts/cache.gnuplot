# vim: set syntax=gnuplot syntax :

set term pdfcairo font "Arial,10" dashed
set linetype 1 lw 3 lc rgb "#D02720"  pointtype 7 ps 0.5
set linetype 2 lw 3 lc rgb "#1FD9B2" pointtype 11 ps 0.75
set linetype 3 lw 3 lc rgb "#3ADE58" pointtype 8 ps 0.75
set linetype 4 lw 1 lc rgb "gray" pointtype 0
set grid xtics ytics lw 1 lc rgb 'gray'

set xlabel 'Nº hilos de búsqueda'

arch='img/cache.pdat'
set key left top
set xrange [0.5:11.5]
set xtics 1

escala=1000000

set ylabel "Millones de fallos cache"
set output 'img/cache_fallos.pdf'
set title "Fallos de cache para distintas cantidad de fragmentos"
plot arch using 1:($3/escala) with linespoints lt 1 title '1 fragmento', \
 arch using 1:($5/escala) with linespoints lt 2 title '2 fragmentos', \
 arch using 1:($7/escala) with linespoints lt 3 title '12 fragmentos'

set ylabel "Millones de accesos a cache"
set output 'img/cache_accesos.pdf'
set title "Accesos a la cache para distintas cantidad de fragmentos"
plot arch using 1:($2/escala) with linespoints lt 1 title '1 fragmento', \
 arch using 1:($4/escala) with linespoints lt 2 title '2 fragmentos', \
 arch using 1:($6/escala) with linespoints lt 3 title '12 fragmentos'

set ylabel "Accesos/Fallos a cache"
set output 'img/cache_accesosfallos.pdf'
set title "Accesos/Fallos a la cache para distintas cantidad de fragmentos"
plot arch using 1:($2/$3) with linespoints lt 1 title '1 fragmento', \
 arch using 1:($4/$5) with linespoints lt 2 title '2 fragmentos', \
 arch using 1:($6/$7) with linespoints lt 3 title '12 fragmentos'

