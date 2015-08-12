
CFLAGS = -g -Wall

# NOTE if one of these headers does not exist, the wildcard rule fails.
HFILES = src/cc/c.h src/ds/ds.h src/mem/mem.h
CCO    = src/cc/cpp.o \
         src/cc/lex.o \
         src/cc/parse.o \
         src/cc/types.o \
         src/cc/error.o
MEMO   = src/mem/mem.o
DSO    = src/ds/list.o \
         src/ds/map.o \
         src/ds/vec.o \
         src/ds/strset.o
LIBO   = $(CCO) $(MEMO) $(DSO)
CO     = src/cmd/c/emit.o \
         src/cmd/c/main.o 
CPPO   = src/cmd/cpp/main.o 

all:  bin/c bin/cpp

.PHONY: all clean

%.o: %.c $(HFILES)
	$(CC) $(CFLAGS) -Isrc/ -o $@ -c $<

bin/c: $(CO) $(LIBO)
	@ mkdir -p bin
	$(CC) $(CO) $(LIBO) -o $@

bin/cpp:  $(CPPO) $(LIBO)
	@ mkdir -p bin
	$(CC) $(CPPO) $(LIBO) -o $@

clean:
	rm -rf $(LIBO) $(CPPO) $(CO) bin 
