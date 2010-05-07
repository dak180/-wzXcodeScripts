cd external/pixman

cat <<EOF > config.h
#define AC_APPLE_UNIVERSAL_BUILD
#define HAVE_DLFCN_H 1
#define HAVE_INTTYPES_H 1
#define HAVE_MEMORY_H 1
#define HAVE_STDINT_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRINGS_H 1
#define HAVE_STRING_H 1
#define HAVE_SYS_STAT_H 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_UNISTD_H 1
#define PACKAGE "pixman"
#define PACKAGE_BUGREPORT ""sandmann@daimi.au.dk""
#define PACKAGE_NAME "pixman"
#define PACKAGE_STRING "pixman 0.14.0"
#define PACKAGE_TARNAME "pixman"
#define PACKAGE_VERSION "0.14.0"
#define STDC_HEADERS 1
#define VERSION "0.14.0"
#if defined AC_APPLE_UNIVERSAL_BUILD
# if defined __BIG_ENDIAN__
#  define WORDS_BIGENDIAN 1
# endif
#else
# ifndef WORDS_BIGENDIAN
#  define USE_MMX 1
# endif
#endif
EOF