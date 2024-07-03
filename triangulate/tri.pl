use Math::Trig;
open A,"ang.dat" or die;

# Width in pixels of each image
@iw=(8258,8125,8227,8118);
$iw[$_]*=0.5 foreach 0..3;

# Counters for the number of occurrences of each circle in the data file. There
# should be two each.
$m[$_]=0 foreach 0..72;

while(<A>) {
    @o=split;
    if($o[0]=~/^IM(\d)/) {
        $set=$1;
        $v[$1][0]=$o[1];
        $v[$1][1]=$o[2];
        $v[$1][2]=$o[3];
    } elsif ($#o==1) {
        $p[$o[0]][$m[$o[0]]]=$o[1];
        $P[$o[0]][$m[$o[0]]++]=$set;
    }
}

$h=504;
$w=285.75;
$c=468;   #was 448 error?
$d=210.75;
$a=12;

foreach (0..3) {

    if($_%2==0) {
        $x1=($c-$a);$y1=$w;
        $x2=($h-$a);$y2=0;$sh=0;
    } else {
        $x1=($h-$a);$y1=0;
        $x2=($c-$a);$y2=-$w;$sh=1;
    }

    if($_<2) {
        $y1-=$d;$y2-=$d;
    } else {
        $y1+=$d;$y2+=$d;
    }

    $T1=$y1/$x1;
    $T2=$y2/$x2;

    $al=$iw[$_]-$v[$_][$sh];
    $be=$iw[$_]-$v[$_][$sh+1];

    #print "$al $be\n";
    #print "($x1,$y1) ($x2,$y2)\n";
    #print "$T1 $T2\n";

    $qa=($al*$T1-$be*$T2);
    $qb=($al-$be)*(1-$T1*$T2);
    $qc=$be*$T1-$al*$T2;

    $TA[$_]=(-$qb+sqrt($qb*$qb-4*$qa*$qc))/(2*$qa);
    #$TB=(-$qb-sqrt($qb*$qb-4*$qa*$qc))/(2*$qa);

    $qA[$_]=$al*(1+$T1*$TA[$_])/($T1-$TA[$_]);
    #$qB=$al*(1+$T1*$TA)/($T1-$TA);

    #$phi1=atan2($y1,$x1);
    #$phi2=atan2($y2,$x2);
    #$theta=atan($TA);

    #print "$_ $TA[$_] $qA[$_]\n";

    #print "$TA $TB\n";
    #print "$qA $qB\n\n";
}

foreach $n (0..72) {
    $S=$P[$n][0];
    #print "$p[$n][0] $p[$n][1]\n";

    #printf "%g %g\n",$iw[$S]-$p[$n][0],$iw[$S+2]-$p[$n][1];
    #printf "%g %g\n",$TA[$S],$TA[$S+2];

    $psi=($iw[$S]-$p[$n][0])/$qA[$S];
    $px=1-$psi*$TA[$S];
    $py=$TA[$S]+$psi;
    #print "$psi  1 $TA[$S] $px $py\n";

    $psi=($iw[$S+2]-$p[$n][1])/$qA[$S+2];
    $rx=1-$psi*$TA[$S+2];
    $ry=$TA[$S+2]+$psi;
    #print "$psi  1 $TA[$S+2] $rx $ry\n";

    $mu=2*$d*$px/($ry*$px-$rx*$py);
    $cx=-($a+$mu*$rx);
    $cy=-$d+$mu*$ry;

    print "$n $cy $cx\n";

    #die;
    #foreach (0..200) {
    #    $lam=$_*2;
    #
    #   $x1=$a+$lam*$px;
    #   $y1=$d+$lam*$py;
    #
    #   $x2=$a+$lam*$rx;
    #   $y2=-$d+$lam*$ry;
    #
    #   print "$x1 $y1 $x2 $y2 $cx $cy\n";
    #}
}
print "78 0 -20";
