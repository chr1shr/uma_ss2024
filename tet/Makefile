include ../config.mk

all: tetrahedron

tetrahedron: tetrahedron.cc
	$(cxx) $(cflags) $(voro_iflags) -o $@ $^ $(voro_lflags)

clean:
	rm -f tetrahedron

.PHONY: clean all 
