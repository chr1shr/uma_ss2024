#include "voro++.hh"
using namespace voro;

// Set up constants for the container geometry
const double x_min=-5,x_max=5;
const double y_min=-5,y_max=5;
const double z_min=0,z_max=10;

// Set up the number of blocks that the container is divided into
const int n_x=6,n_y=6,n_z=6;

int main(int argc,char **argv) {

    // Create a container with the geometry given above, and make it
    // non-periodic in each of the three coordinates. Allocate space for
    // eight particles within each computational block
    container_2d con(-285.75,285.75,-504,28,4,4,false,false,8);

    //Randomly add particles into the container
    double winfo[16]={53.5,28,210.75,0,
                      -210.75,0,-53.5,28,
                      -91,-504,-285.75,-468,
                      285.75,-468,91,-504};
    wall_line* wp[4];
    for(int i=0;i<4;i++) {
        double rx,ry,px,py;
        rx=winfo[4*i];
        ry=winfo[4*i+1];
        px=winfo[4*i+2];
        py=winfo[4*i+3];
        
        wp[i]=new wall_line(ry-py,px-rx,-(rx*py-ry*px));
        con.add_wall(wp[i]);
    }
    con.import("out12");

    // Save the Voronoi network of all the particles to text files
    // in gnuplot and POV-Ray formats
    con.draw_cells_gnuplot("out12.gnu");
    con.print_custom("%i %q %a %n","out12.nei");

    for(int i=0;i<4;i++) delete wp[i];
}
