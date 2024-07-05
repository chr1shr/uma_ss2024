#include "void.hh"

#include <sys/types.h>
#include <sys/stat.h>

int main() {

    // Create output directory
    mkdir("void.odr",S_IRWXU|S_IRWXG|S_IROTH|S_IXOTH);

    // Create a 15 by 100 lattice and initialize particles up to height of 90
    void_model v(15,100,5);
    v.init(90);

    // Create 801 output frames, each time passing a void through on a random
    // walk
    v.output_pov(0);
    for(int k=1;k<=800;k++) {
        v.drain();
        v.output_pov(k);
    }
}
