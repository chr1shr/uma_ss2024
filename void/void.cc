#include "void.hh"
#include "common.hh"

#include <cstdio>
#include <cmath>

/** Initializes the particles in the lattice up to a given height.
 * \param[in] h the height to initialize up to; anything above this will be
 *              filled with empty space. */
void void_model::init(int h) {
    int j=0;char *cp=c;
    while(j<h) {
        for(int i=0;i<m;i++,cp++) *cp=1+(5*i)/m;
        j++;
    }
    while(cp<c+mn) *(cp++)=0;
}

/** Propagates a void through the lattice, rearranging the particles
 * according to its influence.
 * \param[in] (i,j) the starting lattice position of the void. */
void void_model::walk(int i,int j) {
    int ii[2],ni,opt;
    while(j<n-1) {

        // Find the possible options for where the void could move to. Most of
        // the time, the void could move up-left or up-right. But its movement
        // may be restricted if it is close to a boundary if particles aren't
        // present in the up-left/up-right locations.
        opt=0;
        if(c[j*m+m+i]!=0) {*ii=i;opt++;}
        if(j&1) {
            if(i<m-1&&c[j*m+m+i+1]!=0) ii[opt++]=i+1;
        } else {
            if(i>0&&c[j*m+m+i-1]!=0) ii[opt++]=i-1;
        }

        // Choose the next location for the void. If there are two options then
        // randomly switch between. If there is one option, then just move
        // there. If there are no options, then terminate.
        if(opt==2) ni=ii[rand_bit()?1:0];
        else if(opt==1) ni=*ii;
        else break;

        // Shift the particle from the new location into the current location
        c[j*m+i]=c[j*m+m+ni];
        i=ni;
        j++;
    }
    c[j*m+i]=0;
}

/** Outputs the lattice state in a format for plotting with Gnuplot.
 * Creates separate data files for each particle type. */
void void_model::output_gnuplot() {

    // Open files loc0.dat, loc1.dat, loc2.dat, ... for saving the particle
    // information
    FILE** fp=new FILE*[st+1];
    for(int i=0;i<=st;i++) {
        sprintf(buf,"loc%d.dat",i);
        fp[i]=safe_fopen(buf,"w");
    }

    // Output the particle data and close the files
    char *cp=c;
    for(int j=0;j<n;j++) for(int i=0;i<m;i++,cp++)
        fprintf(fp[int(*cp)],"%g %g\n",sqrt(0.75)*(j&1?2*i+1:2*i),j*0.5);
    for(int i=0;i<=st;i++) fclose(fp[i]);
    delete [] fp;
}

/** Outputs the lattice state in a format for rendering with POV-Ray.
 * \param[in] k the suffix to apply to the filename. */
void void_model::output_pov(int k) {
    sprintf(buf,"void.odr/fr_%04d.inc",k);
    FILE *fp=safe_fopen(buf,"w");
    char *cp=c;
    for(int j=0;j<n;j++) for(int i=0;i<m;i++,cp++)
        if(*cp>0) fprintf(fp,"sphere{<%g,0,%g>,r texture{t%d}}\n",
                          sqrt(0.75)*(j&1?2*i+1:2*i),j*0.5,int(*cp));
    fclose(fp);
}

/** Simulates a void being introduced at the orifice at the seventh lattice
 * site, and lets it propagate to the top of the particles. */
void void_model::drain() {
    walk(7,rand_bit()?1:0);
}
