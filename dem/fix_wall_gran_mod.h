/* ----------------------------------------------------------------------
   LAMMPS - Large-scale Atomic/Molecular Massively Parallel Simulator
   http://lammps.sandia.gov, Sandia National Laboratories
   Steve Plimpton, sjplimp@sandia.gov

   Copyright (2003) Sandia Corporation.  Under the terms of Contract
   DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains
   certain rights in this software.  This software is distributed under 
   the GNU General Public License.

   See the README file in the top-level LAMMPS directory.
------------------------------------------------------------------------- */

#ifdef FIX_CLASS

FixStyle(wall/gran,FixWallGran)

#else

#ifndef LMP_FIX_WALL_GRAN_H
#define LMP_FIX_WALL_GRAN_H

#include "fix.h"
#include "fix_wear.h"
#include "fix_stresses.h"

namespace LAMMPS_NS {

class FixWallGran : public Fix {
 public:
  FixWallGran(class LAMMPS *, int, char **);
  ~FixWallGran();
  int setmask();
  void init();
  void setup(int);
  void post_force(int);
  void post_force_respa(int, int, int);

  double memory_usage();
  void grow_arrays(int);
  void copy_arrays(int, int);
  void set_arrays(int);
  int pack_exchange(int, double *);
  int unpack_exchange(int, double *);
  int pack_restart(int, double *);
  void unpack_restart(int, int);
  int size_restart(int);
  int maxsize_restart();
  void reset_dt();
  void register_wear(FixWear* fw_) {fw=fw_;};
  void register_stresses(FixStresses *fe_) {fe=fe_;}
  void unregister_stresses() {fe=NULL;}

 private:
  int wallstyle,pairstyle,wiggle,wshear,axis;
  double kn,kt,gamman,gammat,xmu;
  double lo,hi,cylradius;
  double wc0,wc1,wc2,wc3,wc4;
  double amplitude,period,omega,vshear;
  double dt;
  int nlevels_respa;
  int time_origin;

  FixWear *fw;
  FixStresses *fe;
  int *touch;
  double **shear;

  void hooke(double, double, double, double, double *,
	     double *, double *, double *, double *, double, double,int);
  void hooke_history(double, double, double, double, double *,
		     double *, double *, double *, double *, double, double,
		     double *,int);
  void hertz_history(double, double, double, double, double *,
		     double *, double *, double *, double *, double, double,
		     double *,int);
};

}

#endif
#endif
