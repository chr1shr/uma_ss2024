# Rotating movie of Voronoi tessellation in a tetrahedron
The program **tetrahedron.cc** uses Voro++ to compute a Voronoi tessellation
in a tetrahedron. It is one of the [standard Voro++
examples](https://math.lbl.gov/voro++/examples/tetrahedron/) to demonstrate
the usage of plane wall objects to impose boundary constraints.

Compiling and running the program will create several output files containing
the Voronoi tessellation. The file **tetrahedron_p.pov** contains the particle
positions in POV-Ray format, and the file **tetrahedron_v.pov** contains the
Voronoi cells in POV-Ray format.

The scripts **pov-movie.pl** can render movie frames using
[POV-Ray](https://www.povray.org), rotating around the tetrahedron. Using the
`-v` flag with the script enables verbose POV-Ray output. The rendering can be
split across multiple hosts with the `-r` flag. See the README.md file in the
top level directory for more information about how to set this up.

Once the frames are rendered, the script assembles them into a movie using
[FFmpeg](https://ffmpeg.org).
