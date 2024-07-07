#!/usr/bin/perl
# This script assumes that the lloyd.pl script has already been run to generate
# the particle positions

# Output directory filename
$odir="lloyd_output";

foreach $n (0..256) {
    print "$n\n";

    # Run Voro++ to obtain the neighbor information
    system "./v2d 2 $odir/lloyd_p.$n temp.nei";
    open A,"temp.nei" or die;
    $w=0;
    while(<A>) {
        @b=split;

        # Store particle ID and position
        $i=$b[0];
        $x[$i]=$b[1];
        $y[$i]=$b[2];

        # Store neighbors
        foreach (3..$#b) {
            $r[$w++]=$i,$r[$w++]=$b[$_] if $b[$_]>=0;
        }
    }
    close A;

    # Output Delaunay triangulation based on Voronoi neighbors
    open B,">$odir/lloyd_d.$n" or die;
    $l=0;
    while($l<$w) {
        $i=$r[$l++];
        $j=$r[$l++];
        print B "$x[$i] $y[$i]\n$x[$j] $y[$j]\n\n\n";
    }
    close B;

    # Plot the particles and their Voronoi cells
    open C,">temp.gnuplot";
print C <<EOF;
A='$odir/lloyd_v.$n'
B='$odir/lloyd_p.$n'
C='$odir/lloyd_d.$n'

set style line 1 pt 7 lw 2 lc rgb "#e0e0e0"
set style line 2 pt 7 lw 2.1 lc rgb "#ff0000"
set style line 3 pt 7 lw 2 lc rgb "#ff00ff"

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
plot A u 1:2 w lp ls 1 ps 0.2, C w l ls 3 lw 2, B u 2:3 w p pt 7 lt 0 lw 2
set output
!epstopdf temp.eps
EOF
    close C;
    system "gnuplot temp.gnuplot";

    # Convert PDF plot to an image
    $fn=sprintf "ld_%04d.png",$n-1;
    system "convert -background white -density 600 -geometry 936x936 temp.pdf -flatten png24:$odir/$fn";
}

# Create movie using FFmpeg
system "ffmpeg -r 30 -y -i $odir/ld_%4d.png -preset veryslow -c:v libx265 -crf 17 -pix_fmt yuv420p -tag:v hvc1 -movflags faststart lloyd3.mov";
