# vim: set syntax=gnuplot syntax :

set term pdfcairo font "Arial,10" dashed
set linetype 1 lw 3 lc rgb "#D02720"  pointtype 7 ps 0.5
set linetype 2 lw 3 lc rgb "#1FD9B2" pointtype 11 ps 0.75
set linetype 3 lw 3 lc rgb "#3ADE58" pointtype 8 ps 0.75
set grid xtics ytics lw 1 lc rgb 'gray'

set xlabel 'Nº particiones'

arch='img/primos.pdat'

set ylabel "FPS"
set output 'img/primos_fps.pdf'
set title "Cuadros por segundo para números primos y sus inmediatos"
plot arch using 1:7 with linespoints lt 1 title 'N', \
 arch using ($1-1):8 with linespoints lt 2 title 'N-1', \
 arch using ($1+1):9 with linespoints lt 3 title 'N+1'

set ylabel "Mega Píxeles"
set output 'img/primos_area.pdf'
set title "Área total de la imagen para números primos y sus inmediatos"
plot arch using 1:($2*$1)/1000000 with linespoints lt 1 title 'N', \
 arch using ($1-1):($3*($1-1))/1000000 with linespoints lt 2 title 'N-1', \
 arch using ($1+1):($4*($1+1))/1000000 with linespoints lt 3 title 'N+1'

