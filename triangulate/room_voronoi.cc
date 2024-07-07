#include "voro++.hh"
using namespace voro;

int main(int argc,char **argv) {

    // Initialize the 2D domain representing the lecture room. Distances are
    // measured in inches. 
    container_2d con(-285.75,285.75,-504,28,4,4,false,false,8);

    // The lecture room is modeled as an irregular octagon. Four walls are
    // added to create the extra faces. Each wall is specified in terms
    // of two points on it.
    double winfo[16]={53.5,28,210.75,0,
                      -210.75,0,-53.5,28,
                      -91,-504,-285.75,-468,
                      285.75,-468,91,-504};
    wall_line* wp[4];
    for(int i=0;i<4;i++) {
        double &rx=winfo[4*i],
               &ry=winfo[4*i+1],
               &px=winfo[4*i+2],
               &py=winfo[4*i+3];
        
        // Compute wall object by calculating the wall normal and the wall
        // displacement       
        wp[i]=new wall_line(ry-py,px-rx,-(rx*py-ry*px));
        con.add_wall(wp[i]);
    }
    con.import("class.dat");

    // Save the Voronoi network of all the particles to text files
    // in gnuplot and POV-Ray formats
    con.draw_cells_gnuplot("class.gnu");
    con.print_custom("%i %q %a %n","class.nei");

    // Free the dynamically allocated wall objects
    for(int i=0;i<4;i++) delete wp[i];
}
