A='small_example.gnu'
B='small_example.par'
C='small_single.gnu'
D='rect.dat'
E='small_prd.gnu'
F='small_example.dln'

set style line 1 pt 7 lw 2 lc rgb "#0000ff"
set style line 2 pt 7 lw 2.1 lc rgb "#ff0000"
set style line 3 pt 7 lw 2 lc rgb "#ff55ff"
set style line 4 pt 7 lw 2 lc rgb "#999999"

#set term pdf color solid linewidth 2 size 2in,2in
#set output 'small.pdf'
set term epscairo color solid linewidth 2 size 2in,2in
set size ratio -1
set size 1,1
ep=0.1
set pointsize 0.6
set xrange [-ep:1+ep]
set yrange [-ep:1+ep]
unset border
unset xtics
unset ytics
unset key
set lmargin 0
set tmargin 0
set bmargin 0
set rmargin 0

set output '2d_small_a.eps'
plot D u 1:2 w lp ls 4 ps 0.1, B u 2:3 w p pt 2 lt 0 lw 2
set output '2d_small_b.eps'
plot A u 1:2 w lp ls 1 ps 0.3, B u 2:3 w p pt 2 lt 0 lw 2
set output '2d_small_c.eps'
plot A u 1:2 w lp ls 1 ps 0.3, B u 2:3 w p pt 2 lt 0 lw 2, C w lp ls 2 ps 0.31
set output '2d_small_d.eps'
plot E u 1:2 w lp ls 1 ps 0.3, B u 2:3 w p pt 2 lt 0 lw 2
set output '2d_small_e.eps'
plot A u 1:2 w lp ls 1 ps 0.3, B u 2:3:(0.045) w circles lw 2 lc rgb "#f0a033", C w lp ls 2 ps 0.31
set output '2d_small_f.eps'
plot A u 1:2 w lp ls 1 ps 0.3, F w l ls 3, B u 2:3 w p pt 2 lt 0 lw 2
set output '2d_small_g.eps'
plot D u 1:2 w lp ls 4 ps 0.1, F w l ls 3, B u 2:3 w p pt 2 lt 0 lw 2
set output
!epstopdf 2d_small_a.eps
!epstopdf 2d_small_b.eps
!epstopdf 2d_small_c.eps
!epstopdf 2d_small_d.eps
!epstopdf 2d_small_e.eps
!epstopdf 2d_small_f.eps
!epstopdf 2d_small_g.eps
