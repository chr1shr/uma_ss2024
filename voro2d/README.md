# Two-dimensional Voronoi test cases
These files generate some of the small Voronoi tessellation examples used in
the lectures. There are several data files with particle positions

- **small_example.par** – contains twenty particles at random positions in the
  domain [0,1]&sup2;

- **small_sorted.par** – contains the same twenty particles but sorted by
  particle ID

- **particles_spiral** – contains particles arranged in a spiral

The C++ program **v2d.cc** provide an interface to some basic functionality of
Voro++. It can output Voronoi cells, Voronoi cell centroids, and Voronoi cell
neighbor information.

# Scripts
Several scripts act on these particle data files: 

- **incremental.pl** – creates a movie showing the Voronoi tessellation when
  particles are added sequentially. It illustrates one possible algorithm for
  computing the Voronoi cells.

- **gen_small.pl** – creates several Voronoi output files from the
  twenty-particle data file. These can be subsequently plotted using the
  **2d_small.gnuplot** Gnuplot script.

- **lloyd.pl** – performs Lloyd's iteration on the spiral particle arrangment
  and creates a movie of the Voronoi cells

- **mesh.pl** – creates a movie of the Delaunay triangulation of the Lloyd's
  iteration results
