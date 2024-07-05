#ifndef VOID_HH
#define VOID_HH

#include <cstdlib>

/** Class representing a void model simulation on a two-dimensional hexagonal
 * lattice. */
class void_model {
    public:
        /** The horizontal size of the lattice. */
        const int m;
        /** The vertical size of the lattice. */
        const int n;
        /** The total number of lattice locations. */
        const int mn;
        /** The number of particle types to initialize in vertical strips. */
        const int st;
        /** The particle data on the lattice sites. */
        char* const c;
        /** Initializes the class and sets up memory for the particles.
         * \param[in] (m_,n_) the dimensions of the lattice. */
        void_model(int m_,int n_,int st_) : m(m_), n(n_), mn(m*n), st(st_),
            c(new char[mn]), bits(0) {}
        /** The class destructor frees the dynamically allocated memory. */
        ~void_model() {
            delete [] c;
        }
        void init(int h);
        void walk(int i,int j);
        void drain();
        void output_gnuplot();
        void output_pov(int k);
    private:
        /** A temporary buffer for creating filenames. */
        char buf[128];
        /** The current random number to read random bits from. */
        unsigned int rnum;
        /** The total number of available random bits in the random number. */
        int bits;
        /** Calculates a random bit.
         * \return The random bit as either true or false with equal
         * probability. */
        inline bool rand_bit() {

            // If there are no available bits, then generate a new random
            // number. (This assumes that the random numbers have at least 32
            // bits, which is true on most modern hardware.) */
            if(bits==0) {rnum=rand();bits=32;}

            // If there are already available bits, then use one of them and
            // remove it from the random number
            else {rnum>>=1;bits--;}
            return rnum&1;
        }
};

#endif
