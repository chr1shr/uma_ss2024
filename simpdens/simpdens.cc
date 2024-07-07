#include <cstdio>
#include <cmath>

// Spacing for hexagonal lattice
const double a=1;
const double b=sqrt(3);

// Half-width for box
const double e=4;

// Computes the area of a unit circle centered at (x,0) that overlaps with the
// right half plane
double slice(double x) {
    double acs=acos(-x);
    return acs-0.5*sin(2*acs);
}

// Computes the area of a unit circle centered at (x,y) that overlaps with the
// upper right quadrant
double circ_frac(double x,double y) {
    if(y<-1) return 0;
    else if(y<1) {
        if(x<=-1) return 0;
        if(x>=1) return slice(y);
        if(x*x+y*y<1) return 0.5*(acos(-x)-asin(-y)+x*sqrt(1-x*x)+y*sqrt(1-y*y)+2*x*y);
        return x<0?(y<0?0:slice(x))
                  :(y<0?slice(y):slice(x)+slice(y)-M_PI);
    } else return x<-1?0:(x<1?slice(x):M_PI);
}

int main() {
    int s;
    double s2,c,d,xx,yy,c80=cos(M_PI*80/180),s80=sin(M_PI*80/180);

    // Open the output file
    FILE *fp=fopen("simpdens.dat","w");
    if(fp==NULL) {
        fputs("File output error\n",stderr);
        return 1;
    }

    // Loop over scanning windows centered at (x,0) with x varying
    for(double x=-7.5;x<=7.51;x+=0.02) {
        s=0;
        s2=0.;

        // Loop over particle positions in a rotated hexagonal lattice
        for(c=-18*a;c<19*a;c+=2*a) for(d=-12*b;d<15*b;d+=2*b) {
            
            // Consider one particle in lattice
            xx=c*c80+d*s80;
            yy=-c*s80+d*c80;

            // Compute density contributions using (a) particle center in/out
            // of window, and (b) fractional particle area within window
            xx=abs(xx-x)-e;
            yy=abs(yy)-e;
            if(xx<0&&yy<0) s++;
            s2+=circ_frac(-xx,-yy);

            // Consider another particle in lattice with a displacement
            xx=(c+a)*c80+(d+b)*s80;
            yy=-(c+a)*s80+(d+b)*c80;

            // Compute density contributions using (a) particle center in/out
            // of window, and (b) fractional particle area within window
            xx=abs(xx-x)-e;
            yy=abs(yy)-e;
            if(xx<0&&yy<0) s++;
            s2+=circ_frac(-xx,-yy);
        }

        // Print out the density measures for method (a) and method (b)
        fprintf(fp,"%g %g %g\n",x,s*M_PI/(4*e*e),s2/(4*e*e));
    }
    fclose(fp);
}
