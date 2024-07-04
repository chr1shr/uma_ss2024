include ../config.mk

objs=common.o void.o
src=$(patsubst %.o,%.cc,$(objs))
execs=v_model

all: $(execs)

depend: $(src)
	$(cxx) $(iflags) -MM $(src) >Makefile.dep

-include Makefile.dep

v_model: v_model.cc void.o common.o 
	$(cxx) $(cflags) -o $@ $^

%.o: %.cc
	$(cxx) $(cflags) -c $<

clean:
	rm -f $(execs) $(objs)

.PHONY: clean data all executables depend
