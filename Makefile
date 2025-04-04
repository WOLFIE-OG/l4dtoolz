# Makefile

HX_SDK = ../hl2sdk-l4d2
HX_METAMOD = ../mmsource
#
# l4dtoolz_mm.so
#

HX_INCLUDE = -I. \
	-I$(HX_METAMOD)/core \
	-I$(HX_METAMOD)/core/sourcehook \
	-I$(HX_SDK)/public \
	-I$(HX_SDK)/public/tier0 \
	-I$(HX_SDK)/public/tier1 \
	-I$(HX_SDK)/public/engine \
	-I$(HX_SDK)/public/mathlib

#
HX_FLAGS = -DSOURCE_ENGINE=9

#
HX_FLAGS += -DSE_EPISODEONE=1 \
	-DSE_DARKMESSIAH=2 \
	-DSE_ORANGEBOX=3 \
	-DSE_BLOODYGOODTIME=4 \
	-DSE_EYE=5 \
	-DSE_CSS=6 \
	-DSE_ORANGEBOXVALVE=7 \
	-DSE_LEFT4DEAD=8 \
	-DSE_LEFT4DEAD2=9 \
	-DSE_ALIENSWARM=10 \
	-DSE_PORTAL2=11 \
	-DSE_CSGO=12

#
HX_FLAGS += -DPOSIX \
	-Dstricmp=strcasecmp \
	-D_stricmp=strcasecmp \
	-D_strnicmp=strncasecmp \
	-Dstrnicmp=strncasecmp \
	-D_snprintf=snprintf \
	-D_vsnprintf=vsnprintf \
	-D_alloca=alloca \
	-Dstrcmpi=strcasecmp \
	-Wall \
	-Werror \
	-Wno-switch \
	-Wno-unused \
	-msse \
	-DHAVE_STDINT_H \
	-m32 \
	-DNDEBUG \
	-O3 \
	-funroll-loops \
	-pipe \
	-fno-strict-aliasing \
	-D_LINUX \
	-mfpmath=sse \
	-fvisibility=hidden \
	-Wno-non-virtual-dtor \
	-Wno-overloaded-virtual \
	-Wno-deprecated-register \
	-fno-exceptions \
	-fno-rtti \
	-fvisibility-inlines-hidden

#
HX_LIB = Release/l4dtoolz_mm.o \
	Release/signature.o \
	$(HX_SDK)/lib/linux/tier1_i486.a \
	libvstdlib_srv.so \
	libtier0_srv.so

#
all:
	mkdir -p Release
	ln -sf $(HX_SDK)/lib/linux/libvstdlib_srv.so libvstdlib_srv.so;
	ln -sf $(HX_SDK)/lib/linux/libtier0_srv.so libtier0_srv.so;
#
	clang $(HX_INCLUDE) $(HX_FLAGS) -o Release/l4dtoolz_mm.o -c l4dtoolz_mm.cpp
	clang $(HX_INCLUDE) $(HX_FLAGS) -o Release/signature.o -c signature.cpp
	clang $(HX_INCLUDE) $(HX_LIB) -m32 -shared -static-libgcc -ldl -lm -o Release/l4dtoolz_mm.so
#
	rm -rf Release/*.o
