CC=clang
# CFLAGS=
# LDFLAGS=-llibmobiledevice -lplist
# ARCH_FLAGS=-arch x86_64 -arch arm64

OS := $(shell uname)
ifeq ($(OS),Darwin)
  # Nothing special needed for MacOS
else ifeq ($(OS),Linux)
  CFLAGS+=-fblocks
  LDFLAGS+=-lBlocksRuntime
else
  $(error Unsupported operating system: $(OS))
endif


TARGETS=afcclient

all: $(TARGETS)

# %.o: %.c
# $(CC) -c $< -o $@ $(CFLAGS) $(ARCH_FLAGS) $(shell pkg-config --cflags libimobiledevice-1.0)

afcclient: afcclient.o libidev.o 
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS) $(shell pkg-config --libs --cflags libimobiledevice-1.0)

clean:
	rm -rf *.dSYM *.o *.gch $(TARGETS)

