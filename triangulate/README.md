# Classroom triangulation and Voronoi tessellation
Lecture 1 featured an activity where each participant was given a colored
circle indicating a unique particle ID number. They were then asked to:

a. Look around the room and write down a list of IDs of their neighbors, using
    their intuition about what a neighbor is.

b. Look around the room and write down a list of IDs of their neighbors,
    based on their Voronoi cells sharing a face.

c. Estimate the area of their Voronoi cell.

Photos of the participants were then taken from the two sides of the lecture
room. This is enough to reconstruct everyone's position using triangulation, as
described in more detail in the lecture 4 slides. From here, a Voronoi
tessellation can be performed, to compare the neighbor information to a real
calculation.

# Raw data
The file **ang.dat** contains the raw data of horizontal pixel positions of the
three room calibration targets and of the circular markers. The file **nei.dat**
contains all of the submitted neighbor information from the participants.

# Analysis pipeline
- The Perl script **tri.pl** performs the triangulation. It outputs a file
  called **class.dat** that contains the positions of the participants.

- The program **room_voronoi.cc** uses [Voro++](https://math.lbl.gov/voro++) to
  perform the Voronoi tessellation in the lecture room. It outputs the Voronoi
  cell shapes, and a file called **class.nei** that contains the Voronoi
  neighbor information and Voronoi cell areas.

- The program **gen_nei.pl** reads in the **class.nei** data, and the submitted
  information in **nei.dat**. It outputs several data files for plotting.

The Gnuplot scripts **room_voro.gnuplot** and **vol_est.gnuplot** can then be
run on the processed data to create several graphs of results.
