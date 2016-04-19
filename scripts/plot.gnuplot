# vim: set syntax=gnuplot syntax :

#set style line 12 lc rgb '#808080' lt 0 lw 1
#set grid back ls 12

#set title "Video ".resolution."pixeles"
set term pdfcairo font "Arial,10"
set dgrid3d 12,12
#set palette defined (0 '#9ecae1', 300 '#3182bd')

set yrange [0.5:24.5]
set xrange [0.5:11.5]
set ytics 1
set xtics 1, 2
set xtics in scale 0.5
set xlabel "Nº threads búsqueda"
set ylabel 'Nº particiones'
set view map

set palette defined (300 '#0000ff', 600 'white')
set cbrange [ 0 : 60 < * ]

set output resolution.'_fps.pdf'
set title "Cuadros por segundo\n".resolution." pixeles"
plot arch using 1:2:($3/10) with image title '', \
 arch using 1:2:(sprintf('%.1f', ($3/10.0))) with labels font ',10' title ''

set palette defined (0 'white', 300 '#0000ff')
set cbrange [ * : * ]

set output resolution.'_turnArround.pdf'
set title "Tiempo máximo de espera, FSP limitados.\n".resolution." pixeles"
plot arch using 1:2:5 with image title '', \
 arch using 1:2:(sprintf('%.2f', $5)) with labels font ',10' title '' 
