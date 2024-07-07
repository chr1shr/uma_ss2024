#!/usr/bin/perl
use File::Copy;

# Prepare output directory
$odir="lloyd_output";
mkdir $odir;

# Initial particle file
$ifn="particles_spiral";
copy($ifn,"$odir/lloyd_p.0");

# Total frames
$fmax=1024;

foreach $n (0..$fmax) {

    # Create Voronoi cells
    system "./v2d 0 $odir/lloyd_p.$n $odir/lloyd_v.$n";

    # Plot the particles and their Voronoi cells
    open C,">temp.gnuplot";
print C <<EOF;
A='$odir/lloyd_v.$n'
B='$odir/lloyd_p.$n'

set style line 1 pt 7 lw 2 lc rgb "#0000ff"
set style line 2 pt 7 lw 2.1 lc rgb "#ff0000"

set term epscairo color solid linewidth 2 size 6in,6in
set size ratio -1
set size 1,1
ep=0.1
set pointsize 0.3
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
plot A u 1:2 w lp ls 1 ps 0.2, B u 2:3 w p pt 7 lt 0 lw 2
set output
!epstopdf temp.eps
EOF
    close C;
    system "gnuplot temp.gnuplot";

    # Convert PDF plot to an image
    $fn=sprintf "lt_%04d.png",$n;
    system "convert -background white -density 500 -geometry 936x936 temp.pdf -flatten png24:$odir/$fn";

    # Compute Lloyd iteration using centroids of Voronoi cells
    $m=$n+1;
    system "./v2d 1 $odir/lloyd_p.$n $odir/lloyd_p.$m" unless $n==$fmax;
}

# Create movie using FFmpeg
system "ffmpeg -r 60 -y -i $odir/lt_%4d.png -preset veryslow -c:v libx265 -crf 17 -pix_fmt yuv420p -tag:v hvc1 -movflags faststart lloyd.mov";
