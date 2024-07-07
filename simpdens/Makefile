include ../config.mk

all: simpdens

simpdens: simpdens.cc 
	$(cxx) $(cflags) -o $@ $^

clean:
	rm -f simpdens

.PHONY: clean all 
