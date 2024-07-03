#!/usr/bin/perl
@a=(1,2,3,10);
open A,"out12.nei" or die;

$n=0;
while(<A>) {
    @b=split;
    $i=$b[0];
    $x[$i]=$b[1];
    $y[$i]=$b[2];
    $V[$i]=$b[3];
    foreach (4..$#b) {
        $r[$n++]=$i,$r[$n++]=$b[$_] if $b[$_]>=0;
    }
}
close A;

open B,">out12.dln" or die;

$l=0;
while($l<$n) {
    $i=$r[$l++];
    $j=$r[$l++];
    $dx=0.5*($x[$j]-$x[$i]);
    $dy=0.5*($y[$j]-$y[$i]);
    print B "$x[$i] $y[$i] $dx $dy\n";
}
close B;

open C,">out12.pta" or die;
open D,">out12.ptb" or die;
open E,">out12.vch" or die;
open F,"nei.dat" or die;

foreach (0..71) {
    $_=<F>;

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

    $_=<F>;
    @a=split;
    if($#a>1) {
        $vol=$V[$a[0]]/(10.7639*144);
        print "$vol\n";
        if($a[2] eq "msq") {
            print E "$a[0] $vol $a[1]\n";
        } elsif($a[2] eq "ftsq") {
            $a[1]/=10.7639;
            print E "$a[0] $vol $a[1]\n";
        } elsif($a[2] eq "alsq") {
            $a[1]*=0.5476;
            print E "$a[0] $vol $a[1]\n";
        }
    }
    <F>;
}

