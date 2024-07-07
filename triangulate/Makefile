include ../config.mk

all: room_voronoi 

room_voronoi: room_voronoi.cc
	$(cxx) $(cflags) $(voro_iflags) -o $@ $^ $(voro_lflags)

clean:
	rm -f room_voronoi

.PHONY: all clean
