set term epslatex standalone header "\\usepackage{sansmathfonts}\n\\usepackage[T1]{fontenc}\\renewcommand*\\familydefault{\\sfdefault}" size 4.5in,2.8in
set xlabel 'Displacement $x/d$'
set ylabel 'Packing fraction'
unset key
A='simpdens.dat'
set xrange [-3.75:3.75]
set output 'naivedgraph1.tex'
plot A u ($1/2):2 lw 3
set output 'naivedgraph2.tex'
plot A u ($1/2):3 lw 3
set output
!epstopdf simpdgraph1-inc.eps
!epstopdf simpdgraph2-inc.eps
!pdflatex simpdgraph1.tex
!pdflatex simpdgraph2.tex
