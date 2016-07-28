# vim: set syntax=gnuplot syntax :

#set style line 12 lc rgb '#808080' lt 0 lw 1
#set grid back ls 12

#set title "Video ".resolution."pixeles"
set term pdfcairo font "Arial,10"

set xrange [0.5:24.5]
set yrange [0.5:12.5]
set ytics 1
set xtics 1
set ytics in scale 0.5
set ylabel "Nº threads búsqueda"
set xlabel 'Nº particiones'

set palette defined (300 '#0000ff', 600 'white')
set cbrange [ 0 : 60 < * ]

set output resolution.'_fps.pdf'
set title "Cuadros por segundo\nvídeo ".resolution." pixeles."
plot arch using 2:1:($3/10) with image title '', \
 arch using 2:1:(sprintf('%.0f', ($3/10.0))) with labels font ',8' title ''

set palette defined (0 'white', 300 '#0000ff')
set cbrange [ * : * ]

set output resolution.'_turnArround.pdf'
set title "Tiempo máximo de espera, FSP limitados.\nvídeo ".resolution." pixeles.\n(en centésimas de segundo)"
plot arch using 2:1:($5*100) with image title '', \
 arch using 2:1:(sprintf('%.0f', ($5 * 100))) with labels font ',8' title ''

set linetype 1 lw 1 lc rgb "#D02720"  pointtype 7 ps 0.5
set linetype 2 lw 1 lc rgb "#1FD9B2" pointtype 11 ps 0.75
set linetype 3 lw 1 lc rgb "#3ADE58" pointtype 8 ps 0.75
set linetype 4 lw 1 lc rgb "gray" pointtype 0
set grid xtics ytics lw 1 lc rgb 'gray'

set xrange [*:*]
set yrange [*:*]
set cbrange [ 0 : * ]
set ytics autofreq
set xtics autofreq
set ytics in scale 1

arch=resolution.".tdat"

set key off
set ylabel "Tiempo máximo de espera"
set xlabel 'Nº particiones'
set output resolution.'_tFPS.pdf'
set title "Tiempo máximo (minimo) de espera para cada FSP.\nvídeo ".resolution." pixeles.\n(en centésimas de segundo)"
plot arch using ($1/10):2 with points lt 1 title ''
