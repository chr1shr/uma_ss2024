A='class.gnu'
B='class.dat'
E='class.dln'
F='class.pta'
G='class.ptb'

set style line 1 pt 7 lw 2 lc rgb "#0000ff"
set style line 2 pt 7 lw 2.1 lc rgb "#ff0000"
set style line 3 pt 7 lw 2 lc rgb "#ff00ff"
set style line 4 pt 7 lw 2 lc rgb "#999999"

#set term pdf color solid linewidth 2 size 2in,2in
#set output 'small.pdf'
set term epscairo color solid linewidth 2 size 6in,6in
set size ratio -1
set size 1,1
ep=10
set pointsize 0.6
set xrange [-285.75-ep:285.75+ep]
set yrange [-504-ep:28+ep]
unset border
unset xtics
unset ytics
unset key
set lmargin 0
set tmargin 0
set bmargin 0
set rmargin 0

set output 'room_a.eps'
plot A u 1:2 w lp ls 1 ps 0.5, B u 2:3:1 w labels
set output 'room_b.eps'
plot A u 1:2 w lp ls 1 ps 0.5, E w vec ls 3, B u 2:3 w p pt 7 lt 0 lw 2 ps 0.6
set output 'room_c.eps'
plot A u 1:2 w lp ls 1 ps 0.5, F w vec ls 3, B u 2:3 w p pt 7 lt 0 lw 2 ps 0.6
set output 'room_d.eps'
plot A u 1:2 w lp ls 1 ps 0.5, G w vec ls 3, B u 2:3 w p pt 7 lt 0 lw 2 ps 0.6
set output
!epstopdf room_a.eps
!epstopdf room_b.eps
!epstopdf room_c.eps
!epstopdf room_d.eps
