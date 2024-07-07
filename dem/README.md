# LAMMPS input scripts
These input scripts were used to create several granular flow simulations in
the lectures, using [LAMMPS](https://lammps.sandia.gov). LAMMPS can simulate
many different particle interaction models, but the granular model simulating
hard spheres of diameter *d* with frictional contacts is employed. For more
information see the original paper by Silbert *et al.* [1].

The contact parameters used here are based on those by Rycroft *et al.* [2,3].
There are three different input scripts:

- **small.lmp** – this creates the small 350 particle packing from lecture 1,
  by pouring in particles from a fixed height. The packing is roughly
  7*d* &times; 7*d* &times 7*d*.

- **silo_pour.lmp** – this creates a particle packing a rectangular silo,
  matching the geometry used by Rycroft *et al.* [4,5].

- **silo_drain.lmp** – this simulation take the previous pouring simulation as
  a starting condition, and then drains them by opening up a small slit the
  container base.

All three simulations periodically output restart files, which containing a
perfect snapshot of the current simulation state and are sufficient to
restart the simulation. The simulations also output dump files, which list the
particle positions at frequent intervals, and are sufficiently for performing a
wide range of post-processing and analysis.

# Custom slit wall object
LAMMPS supports a range of granular wall objects, including plane and
cylindrical walls. Each wall is specified by creating a function that returns
the minimum distance from a particle position to a wall.

The silo LAMMPS files make use of a custom slit wall object called `zslit`. The
files **fix_wall_gran.cpp** and **fix_wall_gran.h** contain modifications to
implement this additional wall object, and can be incorporated into the LAMMPS
source code.

LAMMPS is under constant development and it is possible that these files may
require adjustments in order to compile with the current LAMMPS version.

# References
1. L. E. Silbert, D. Erta&#350;, G. S. Grest, T. C. Halsey, D. Levine, and S.
   J. Plimpton, *Granular flow down an inclined plane: Bagnold scaling and
   rheology*, Phys. Rev. E **64**, 051302 (2001).
   [doi:10.1103/PhysRevE.64.051302](https://doi.org/10.1103/PhysRevE.64.051302)

2. C. H. Rycroft, T. Lind, S. G&uuml;ntay, and A. Dehbi, *Granular flows in
   pebble bed reactors: dust generation and scaling*, proceedings of [ICAPP
   2012](http://icapp.ans.org/), Chicago, June 24&#8211;28, 2012.
   [[Paper]](http://math.lbl.gov/~chr/papers/12328-final.pdf)

3. C. H. Rycroft, A. Dehbi, T. Lind, and S. G&uuml;ntay, *Granular flow in
   pebble-bed nuclear reactors: Scaling, dust generation, and stress*, Nucl.
   Eng. Design. **265**, 69–84 (2013).
   [doi:10.1016/j.nucengdes.2013.07.010](https://doi.org/10.1016/j.nucengdes.2013.07.010)

4. C. H. Rycroft, M. Z. Bazant, J. W. Landry, and G. S. Grest, *Dynamics of
   Random Packings in Granular Flow*, Phys. Rev. E **73**, 051306 (2006).
   [doi:10.1103/PhysRevE.73.051306](https://doi.org/10.1103/PhysRevE.73.051306)

5. C. H. Rycroft, Y. Wong, and M. Z. Bazant, *Fast spot-based multiscale
   simulations of granular flow*, Powder Technol. **200**, 1–11 (2010).
   [doi:10.1016/j.powtec.2010.01.009](https://doi.org/10.1016/j.powtec.2010.01.009)
