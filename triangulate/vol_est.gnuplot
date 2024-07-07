set term epslatex standalone header "\\usepackage{sansmathfonts}\n\\usepackage[T1]{fontenc}\\renewcommand*\\familydefault{\\sfdefault}" size 5.8in,5.8in
set xlabel 'Estimated Voronoi cell area (m$^2$)'
set ylabel 'Actual Voronoi cell area (m$^2$)'
unset key
set logscale xy
set xrange [0.1:20]
set yrange [0.6:20]
set output 'vol_est.tex'
plot 'class.ves' u 3:2:1 w labels lw 3, x lw 3
set output
!epstopdf vol_est-inc.eps
!pdflatex vol_est.tex
