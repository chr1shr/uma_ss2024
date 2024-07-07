use Math::Trig;

# Width in pixels of each image
@iw=(8258,8125,8227,8118);
$iw[$_]*=0.5 foreach 0..3;

# Counters for the number of occurrences of each circle in the data file. There
# should be two each.
$m[$_]=0 foreach 0..72;

# Read in the data file with horizontal pixel info
open A,"ang.dat" or die;
while(<A>) {
    @o=split;
    if($o[0]=~/^IM(\d)/) {

        # If this is an image header, then read the pixel info for the three
        # calibration targets (back corners plus central clock)
        $set=$1;
        $v[$1][0]=$o[1];
        $v[$1][1]=$o[2];
        $v[$1][2]=$o[3];
    } elsif ($#o==1) {

        # Read in the circle pixel info
        $p[$o[0]][$m[$o[0]]]=$o[1];
        $P[$o[0]][$m[$o[0]]++]=$set;
    }
}
close A;

# Room geometry measured in inches. Throughout this file, the origin is the midpoint
# of the photo baseline (at the front of the lecture room). The +x coordinate points
# toward the back clock. A right-handed coordinate system is used.
$h=504;                         # Distance to back wall (with clock)     
$w=285.75;                      # Distance from center to side walls
$c=468;                         # Distance to back corners
$d=210.75;                      # Distance from center to photo locations
$a=12;                          # Forward displacement of photo location

# Loop over the four photos
foreach (0..3) {

    # Assemble (x1,y1) and (x2,y2) coordinates of the two calibration targets
    # to use
    if($_%2==0) {
        $x1=($c-$a);$y1=$w;
        $x2=($h-$a);$y2=0;$sh=0;
    } else {
        $x1=($h-$a);$y1=0;
        $x2=($c-$a);$y2=-$w;$sh=1;
    }

    # Account for camera position, so that (x1,y1), and (x2,y2) are now vectors
    # from the camera to the calibration target
    if($_<2) {
        $y1-=$d;$y2-=$d;
    } else {
        $y1+=$d;$y2+=$d;
    }

    # Compute slopes of vectors to calibration targets
    $T1=$y1/$x1;
    $T2=$y2/$x2;

    # Compute pixel positions (from center of image) of the calibration targets
    $al=$iw[$_]-$v[$_][$sh];
    $be=$iw[$_]-$v[$_][$sh+1];

    # Compute direction of the photo, and the size of the field of view. (The
    # fields of view should constant since they only depend on the lens. The
    # script find the fields of view are indeed roughly equal.)
    $qa=($al*$T1-$be*$T2);
    $qb=($al-$be)*(1-$T1*$T2);
    $qc=$be*$T1-$al*$T2;
    $TA[$_]=(-$qb+sqrt($qb*$qb-4*$qa*$qc))/(2*$qa);
    $qA[$_]=$al*(1+$T1*$TA[$_])/($T1-$TA[$_]);
}

# Loop over the particles
open B,">class.dat" or die;
foreach $n (0..72) {
    $S=$P[$n][0];

    # Compute direction vector to particle in first photo
    $psi=($iw[$S]-$p[$n][0])/$qA[$S];
    $px=1-$psi*$TA[$S];
    $py=$TA[$S]+$psi;

    # Compute direction vector to particle in second photo
    $psi=($iw[$S+2]-$p[$n][1])/$qA[$S+2];
    $rx=1-$psi*$TA[$S+2];
    $ry=$TA[$S+2]+$psi;

    # Compute particle position as the intersection of the two rays
    $mu=2*$d*$px/($ry*$px-$rx*$py);
    $cx=-($a+$mu*$rx);
    $cy=-$d+$mu*$ry;

    # Print computed position of particle (switching x and y coordinates for
    # plotting)
    print B "$n $cy $cx\n";
}

# Add particle 78 to represent Chris stood at the front of the room
print B "78 0 -20";
