# vim: set syntax=gnuplot syntax :

#set style line 12 lc rgb '#808080' lt 0 lw 1
#set grid back ls 12

#set title "Video ".resolution."pixeles"
set title ""
set term pdfcairo font "Arial,12"

set xrange [0.5:24.5]
set yrange [0.5:12.5]
set ytics 1
set xtics 1
set ytics in scale 0.5
set ylabel "Nº hilos de búsqueda"
set xlabel 'Nº fragmentos'

set palette defined (300 '#0000ff', 600 'white')
set cbrange [ 0 : 60 < * ]

set output resolution.'_fps.pdf'
plot arch using 2:1:($3/10) with image title '', \
 arch using 2:1:(sprintf('%.0f', ($3/10.0))) with labels font ',9' title ''

set palette defined (0 'white', 300 '#0000ff')
set cbrange [ * : * ]

set output resolution.'_turnArround.pdf'
plot arch using 2:1:($5*100) with image title '', \
 arch using 2:1:(sprintf('%.0f', ($5 * 100))) with labels font ',9' title ''

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
set ylabel "Retardo de cuadro\n(en centésimas de segundo)"
set xlabel 'FPS'
set output resolution.'_tFPS.pdf'
plot arch using ($1/10):2 with points lt 1 title ''
