#!/usr/bin/perl

# Run Voro++ to generate Voronoi cells and neighbor information
system "./v2d 0 small_example.par small_example.gnu";
system "./v2d 2 small_example.par small_example.nei";

# Read in the neighbor information
open A,"small_example.nei" or die;
$n=0;
while(<A>) {
    @b=split;

    # Particle ID and position
    $i=$b[0];
    $x[$i]=$b[1];
    $y[$i]=$b[2];

    # Neighbor information
    foreach (3..$#b) {
        $r[$n++]=$i,$r[$n++]=$b[$_] if $b[$_]>=0;
    }
}
close A;

# Use the neighbor information to output the Delaunay triangulation
open B,">small_example.dln" or die;
$l=0;
while($l<$n) {
    $i=$r[$l++];
    $j=$r[$l++];
    print B "$x[$i] $y[$i]\n$x[$j] $y[$j]\n\n\n";
}
