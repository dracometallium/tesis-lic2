# vim: set syntax=gnuplot syntax :

set term pdfcairo font "Arial,12" dashed
set linetype 1 lw 1 lc rgb "#D02720"  pointtype 7 ps 0.5
set linetype 2 lw 1 lc rgb "#1FD9B2" pointtype 11 ps 0.75
set linetype 3 lw 1 lc rgb "#3ADE58" pointtype 8 ps 0.75
set linetype 4 lw 1 lc rgb "gray" pointtype 0
set grid xtics ytics lw 1 lc rgb 'gray'

set xlabel 'N° fragmentos'

arch='img/primos.pdat'

set ylabel "FPS"
set output 'img/primos_fps.pdf'
set title ""
plot arch using 1:($7/10) with linespoints lt 1 title 'N', \
 arch using ($1-1):($8/10) with linespoints lt 2 title 'N-1', \
 arch using ($1+1):($9/10) with linespoints lt 3 title 'N+1'

escala=1000000
set ylabel "Mega Píxeles"
set output 'img/primos_area.pdf'
set key left top
plot 'img/areas.pdat' using 1:($2*$1)/escala with lines lt 4 title 'Área total N', \
 arch using 1:($2*$1)/1000000 with points lt 1 title 'N Primo', \
 arch using ($1-1):($3*($1-1))/escala with points lt 2 title 'N Primo - 1', \
 arch using ($1+1):($4*($1+1))/escala with points lt 3 title 'N Primo + 1'

