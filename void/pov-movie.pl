#!/usr/bin/perl
use Math::Trig;
use Getopt::Std;
getopts("hrv");

# Print help information if requested
if($opt_h) {
    print "Usage: ./povray {options}\n\n";
    print "Options:\n";
    print "-h         (Print this information)\n";
    print "-r         (Render files remotely; requires rhosts file)\n";
    print "-v         (Run POV-Ray with verbose output\n";
    exit 0;
}

# Set variables used for remote processing
if($opt_r) {
    open A,"../rhosts" or die "Can't open remote hosts file\n";
    $rdir=<A>;
    chomp $rdir;
    @nlist=();@nthr=();
    while(<A>) {
        next if /^#/;
        @c=split;
        if($#c>=1) {
            push @nlist,$c[0];
            push @nthr,$c[1];
        }
    }
    close A;
    $nodes=$#nlist+1;
    $queue=$nodes==1?1:0;$h=0;
}

# Set constants
$a=0;$first=1;
$maxcols=1;
$verb=$opt_v?"":">/dev/null 2>/dev/null";

# Set POV-Ray rendering quality options
#$pov_opts="+H1200 +W700 +A0.0001 +R9 -J";    # Extreme quality
$pov_opts="+H1200 +W700 +A0.3 -J";            # Moderate quality

$dr="void.odr";

foreach $a (0..1) {

    # Assemble first section of POV-Ray input file from the master template
    $tf="rtemp$h.pov";
    open T,$opt_r?"| bzip2 -9 -c >$dr/$tf.bz2":">$dr/$tf" or die "Can't open temporary POV file\n";
    open M,"master.pov";
    while(<M>) {
        last if m/PARTICLES/;
        print T;
    }

    $df=sprintf "$dr/fr_%04d.inc",$a;
    open M,$df or die;
    print T while <M>;
    close M;
    close T;

    # Send the POV-Ray file to a node for processing
    $fn=sprintf "fr_%04d.png",$a;
    $pov_cmd="nice -n 19 povray $tf -D +O$fn $pov_opts";
    if($opt_r) {

        # Send the POV-Ray file to a node for processing
        $hst=$nlist[$h];
        print "Frame $a to $hst\n";
        exec "rsync -q $dr/$tf.bz2 $hst:$rdir; ".
             "ssh $hst \"cd $rdir; bunzip2 -f $tf.bz2 ; $pov_cmd +WT$nthr[$h] \" $verb ; ".
             "rsync -q $hst:$rdir/$fn $dr ; ssh $hst \"rm $rdir/$fn $rdir/$tf\" " if ($pid[$h]=fork)==0;

        # Wait for one of the forked jobs to finish
        if ($queue) {
            $piddone=wait;$h=0;
            $h++ while $piddone!=$pid[$h]&&$h<$nodes;
            die "PID return error!\n" if $h>=$nodes;
        } else {
            $h++;$queue=1 if $h>=$nodes-1;
        }
    } else {

        # Run POV-Ray locally
        print "Frame $a\n";
        die if system "cd $dr; $pov_cmd $verb";
    }
}

# Wait for all the remaining forked jobs to finish
print wait foreach 1..($queue?$nodes:$h);

# Convert the frames into a movie. Change "veryslow" to "fast" for faster
# conversion but with slightly larger file size.
system "ffmpeg -r 60 -y -i $dr/fr_%4d.png -preset veryslow -c:v libx265 -crf 17 -pix_fmt yuv420p -tag:v hvc1 -movflags faststart void_model.mov";
