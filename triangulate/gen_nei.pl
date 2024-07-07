#!/usr/bin/perl
open A,"class.nei" or die;

# Read in the information from the computed Voronoi tesselation in the lecture room
$n=0;
while(<A>) {
    @b=split;

    # Particle ID and position
    $i=$b[0];
    $x[$i]=$b[1];
    $y[$i]=$b[2];

    # Voronoi cell area
    $V[$i]=$b[3];

    # Voronoi neighbors
    foreach (4..$#b) {
        $r[$n++]=$i,$r[$n++]=$b[$_] if $b[$_]>=0;
    }
}
close A;

# Output the Delaunay triangulation. Rather than plot a solid line between each
# pair, the data is output so that it can be visualized as two arrows pointing
# at each other. This helps for comparing to class data, which may not be
# symmetric.
open B,">class.dln" or die;
$l=0;
while($l<$n) {
    $i=$r[$l++];
    $j=$r[$l++];
    $dx=0.5*($x[$j]-$x[$i]);
    $dy=0.5*($y[$j]-$y[$i]);
    print B "$x[$i] $y[$i] $dx $dy\n";
}
close B;

# Output a range of diagnostic files using the collected neighbor data
open C,">class.pta" or die;
open D,">class.ptb" or die;
open E,">class.ves" or die;
open F,"nei.dat" or die;

# Loop over the particles (skipping particle 78 for Chris)
foreach (0..71) {
    $_=<F>;

    # Output neighbor relations from part (a)
    @a=split;
    $str="";
    foreach (1..$#a) {
        $i=$a[0];
        $j=$a[$_];
        $dx=0.5*($x[$j]-$x[$i]);
        $dy=0.5*($y[$j]-$y[$i]);
        $str.="$x[$i] $y[$i] $dx $dy\n";
    }
    print C $str;

    # Output neighor relations from part (b)
    $_=<F>;
    unless(/missing/) {
        unless(/same/) {
            $str="";
            @a=split;
            foreach (1..$#a) {
                $i=$a[0];
                $j=$a[$_];
                $dx=0.5*($x[$j]-$x[$i]);
                $dy=0.5*($y[$j]-$y[$i]);
                $str.="$x[$i] $y[$i] $dx $dy\n";
            }
        }
        print D $str;
    }

    # Output data on actual and estimated Voronoi cell areas
    $_=<F>;
    @a=split;
    if($#a>1) {

        # Convert actual Voronoi cell areas from inch squared to meter squared
        $vol=$V[$a[0]]/(10.7639*144);
        if($a[2] eq "msq") {

            # Meter squared - no conversion
            print E "$a[0] $vol $a[1]\n";
        } elsif($a[2] eq "ftsq") {

            # Feet squared - need conversion
            $a[1]/=10.7639;
            print E "$a[0] $vol $a[1]\n";
        } elsif($a[2] eq "alsq") {

            # Arm length squared - use NIH average arm length measure for
            # conversion
            $a[1]*=0.5476;
            print E "$a[0] $vol $a[1]\n";
        }
    }
    <F>;
}

