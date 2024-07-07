#!/usr/bin/perl

# Loop over twenty particles in the small test data file
foreach $n (1..20) {
    print "$n\n";

    # Extract the first n particles from the test file
    open A,"small_sorted.par" or die;
    open B,">temp.par" or die;
    foreach $l (1..$n) {
        $_=<A>;
        print B;
    }
    close B;

    # Perform the Voronoi tessellation on the points
    system " ./v2d 0 temp.par temp.gnu";

    # Plot the Voronoi tessellation using Gnuplot
    open C,">temp.gnuplot";
print C <<EOF;
A='temp.gnu'
B='temp.par'

set style line 1 pt 7 lw 2 lc rgb "#0000ff"
set style line 2 pt 7 lw 2.1 lc rgb "#ff0000"

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

set output 'temp.eps'
plot A u 1:2 w lp ls 1 ps 0.3, B u 2:3 w p pt 2 lt 0 lw 2
set output
!epstopdf temp.eps
EOF
    close C;
    system "gnuplot temp.gnuplot";

    # Convert the PDF to an image
    $fn=sprintf "fr_%04d.png",$n-1;
    system "convert -background white -density 500 -geometry 936x936 temp.pdf -flatten png24:$fn";
}

# Create a movie using FFmpeg
system "ffmpeg -r 1 -y -i fr_%4d.png -preset veryslow -c:v libx265 -crf 17 -pix_fmt yuv420p -tag:v hvc1 -movflags faststart incremental.mov";
