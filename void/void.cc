#include <cstdio>
#include <cmath>
#include <cstdlib>

/** \brief Opens a file and checks the operation was successful.
 *
 * Opens a file, and checks the return value to ensure that the operation
 * was successful.
 * \param[in] filename the file to open.
 * \param[in] mode the cstdio fopen mode to use.
 * \return The file handle. */
FILE* safe_fopen(const char* filename,const char* mode) {
    FILE *temp=fopen(filename,mode);
    if(temp==NULL) fprintf(stderr,"Error opening file \"%s\"",filename);
    return temp;
}

class void_model {
    public:
        const int m;   
        const int n;
        const int mn;
        char* const c;
        void_model(int m_,int n_) : m(m_), n(n_), mn(m*n), c(new char[mn]),
            bits(0) {}
        ~void_model() {
            delete [] c;
        }
        void init(int h); 
        void walk(int i,int j);
        void drain();
        void output_gnuplot();
        void output_pov(int k);
    private:
        unsigned int rnum;
        int bits;
        inline bool rand_bit() {
            if(bits==0) {rnum=rand();bits=32;}
            else {rnum>>=1;bits--;}
            return rnum&1;
        }
};

void void_model::init(int h) {
    int j=0;char *cp=c;
    while(j<h) {
        for(int i=0;i<m;i++,cp++) *cp=1+(5*i)/m;
        j++;
    }
    while(cp<c+mn) *(cp++)=0;
}

void void_model::walk(int i,int j) {
    int ii[2],ni,opt;
    //printf("%g %g\n",sqrt(0.75)*(j&1?2*i+1:2*i),j*0.5);
    while(j<n-1) {
        opt=0;
        if(c[j*m+m+i]!=0) {*ii=i;opt++;}
        if(j&1) {
            if(i<m-1&c[j*m+m+i+1]!=0) ii[opt++]=i+1;
        } else {
            if(i>0&c[j*m+m+i-1]!=0) ii[opt++]=i-1;
        }
        if(opt==2) ni=ii[rand_bit()?1:0];
        else if(opt==1) ni=*ii;
        else break;
        c[j*m+i]=c[j*m+m+ni];
        i=ni;
        j++;
        //printf("%g %g\n",sqrt(0.75)*(j&1?2*i+1:2*i),j*0.5);
    }
    c[j*m+i]=0;
}


void void_model::output_gnuplot() {

    FILE* fp[3];
    *fp=safe_fopen("loc0.dat","w");
    fp[1]=safe_fopen("loc1.dat","w");
    fp[2]=safe_fopen("loc2.dat","w");

    char *cp=c;
    for(int j=0;j<n;j++) for(int i=0;i<m;i++,cp++)
        fprintf(fp[int(*cp)],"%g %g\n",sqrt(0.75)*(j&1?2*i+1:2*i),j*0.5);

    fclose(*fp);
    fclose(fp[1]);
    fclose(fp[2]);
}

void void_model::output_pov(int k) {
    char buf[256];
    sprintf(buf,"void.odr/fr_%04d.inc",k);
    FILE *fp=safe_fopen(buf,"w");
    char *cp=c;
    for(int j=0;j<n;j++) for(int i=0;i<m;i++,cp++)
        if(*cp>0) fprintf(fp,"sphere{<%g,0,%g>,r texture{t%d}}\n",
                          sqrt(0.75)*(j&1?2*i+1:2*i),j*0.5,int(*cp));
    fclose(fp);
}

void void_model::drain() {
    for(int k=0;k<1;k++)
        walk(7,rand_bit()?1:0);
}

int main() {
    void_model v(15,100);
    v.init(90);
    v.output_pov(0);
    for(int k=1;k<=800;k++) {
        v.drain();
        v.output_pov(k);
    }
}
