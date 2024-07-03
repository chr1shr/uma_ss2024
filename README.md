# UMass Summer School 2024 – Computational geometry for soft matter
This repository contains programs and data files from [Chris
Rycroft's](https://people.math.wisc.edu/~chr) lectures at the UMass Amherst
[Summer School on Soft Solids and Complex Fluids](https://websites.umass.edu/softmatter/program-2024/),
which took place from June 2–6, 2024.

Some of the codes are written in C++. To compile these, it is necessary to set
up a common configuration file as described in the next section. Some of the
other codes are written using Perl, a scripting language that is particularly
useful for rapid text file parsing and analysis.

Slides and additional material from the lectures are available on
[Chris Rycroft's website](https://people.math.wisc.edu/~chr/events/uma_ss2024).

# C++ compiler setup
The C++ programs use [GNU Make](https://www.gnu.org/software/make/) to simplify
compilation. They require a common configuration file called **config.mk** to
be placed in the top-level directory. Several templates are provided in the
**config** directory. To use, copy one of the templates into the parent
directory. From the uma\_ss2024 directory, on a Linux computer, type
```Shell
cp config/config.mk.linux ../config.mk
```
On a Mac using GCC 13 installed via [MacPorts](http://www.macports.org), type
```Shell
cp config/config.mk.mac_mp ../config.mk
```
On a Mac using GCC installed via [Homebrew](http://brew.sh), type
```Shell
cp config/config.mk.mac_hb ../config.mk
```
After this, typing `make` within any directory with C++ programs will compile
them.

# Directories
The programs are provided in the following directories

- **dem** – contains input files for LAMMPS for creating discrete-element
  method (DEM) simulations presented in lecture 1

- **simpdens** – contains files for computing the local density of a regular
  two-dimensional packing using two simple methods

- **void** – Implements the void model of particle drainage that was introduced
  in lecture 1

- **voro2d** – Implements the two-dimensional Voronoi tessellation on several
  small test arrangements, using [Voro++](https://math.lbl.gov/voro++)

- **tet** – Creates a movie of a rotating Voronoi tessellation in a tetrahedron

- **triangulate** – Performs the triangulation of the summer school
  participants reconstructed from photos in lecture 1, and uses the Voronoi
  tessellation to examine their neighbor relationships

# Additional resources
Several other software packages were referenced throughout the lectures

- [LAMMPS](https://lammps.sandia.gov) – the Large Atomic/Molecular Massively
  Parallel Simulator is a widely-used software package developed at Sandia
  National Laboratories

- [Voro++](https://math.lbl.gov/voro++) – this software package was released by
  Chris Rycroft in 2009 [1] and performs cell-based computations of the Voronoi
  tessellation in two and three dimensions

- [Zeo++](https://www.zeoplusplus.org) – this software package builds on Voro++
  to perform high-throughput geometric analyses of crystalline porous materials
  [2]

- [VoroTop](https://www.vorotop.org) – this software package builds on Voro++
  to analyze particle packings using the topology of their Voronoi cells [3,4]

- [TriMe++](https://github.com/jiayinlu19960224/TriMe) – this software package
  builds on a multithreaded extension of Voro++ [5] to create two-dimensional
  triangular meshes efficiently [6].

- [IncRMT](https://github.com/chr1shr/incrmt) – this software project implements
  the incompressible reference map technique in two dimensions [7,8], and was
  used to create many of the movies show in lecture 4.

- [RMT3D](https://github.com/ylunalin/RMT3D) – this software project implements
  the incompressible reference map technique in three dimensions and in
  parallel [9], and was used to create the final movie in lecture 4.

# References
1. C. H. Rycroft, *Voro++: A three-dimensional Voronoi cell library in C++*,
   Chaos **19**, 041111 (2009).
   [doi:10.1063/1.3215722](https://doi.org/10.1063/1.3215722)

2. T. F. Willems, C. H. Rycroft, M. Kazi, J. C. Meza, and M. Haranczyk,
   *Algorithms and tools for high-throughput geometry-based	analysis of
   crystalline porous materials*, Microporous and Mesoporous Materials **149**,
   134–141 (2012).
   [doi:10.1016/j.micromeso.2011.08.020](https://10.1016/j.micromeso.2011.08.020)

3. E. A. Lazar, J. Han, and D. J. Srolovitz, *Topological framework for local
   structure analysis in condensed matter*, Proc. Natl. Acad. Sci. **112**,
   E5769–E5776 (2015). [doi:10.1073/pnas.1505788112](https://doi.org/10.1073/pnas.1505788112)

4. E. A. Lazar, J. Lu, C. H. Rycroft, and D. Schwartz, *Voronoi topology in two
   dimensions: theory, algorithms, and applications*,
   [arXiv:2406.00553](https://arxiv.org/abs/2406.00553) (2024).

5. J. Lu, E. Lazar, and C. H. Rycroft, *An extension to Voro++ for
   multithreaded computation of Voronoi cells*, Comput. Phys. Commun.
   **291**, 108832 (2023).
   [doi:10.1016/j.cpc.2023.108832](https://doi.org/10.1016/j.cpc.2023.108832)

6. J. Lu and C. H. Rycroft, *TriMe++: Multi-threaded triangular meshing in two
   dimensions*, [arXiv:2309.13824](https://arxiv.org/abs/2309.13824) (2024).

7. K. Kamrin, C. H. Rycroft, and J.-C. Nave, *Reference map technique for
   finite-strain elasticity and fluid–solid interaction*, J. Mech. Phys. Solids
   **60**, 1952–1969 (2012).
   [doi:10.1016/j.jmps.2012.06.003](https://doi.org/10.1016/j.jmps.2012.06.003)

8. C. H. Rycroft, C.-H. Wu, Y. Yu, and K. Kamrin, *Reference map technique for
   incompressible fluid–structure interaction*, J. Fluid Mech. **898**, A9
   (2020).
   [doi:10.1017/jfm.2020.353](https://doi.org/10.1017/jfm.2020.353)

9. Y. L. Lin, N. J. Derr, and C. H. Rycroft, *Eulerian simulation of complex
   suspensions and biolocomotion in three dimensions*, Proc. Natl. Acad. Sci.
   **119**, e2105338118 (2022).
   [doi:10.1073/pnas.2105338118](https://doi.org/10.1073/pnas.2105338118)
