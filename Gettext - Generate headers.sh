cd external/gettext/gettext-runtime


cat <<EOF > config.h
#define ENABLE_NLS 1
#define GNULIB_FWRITEERROR 1
#define HAVE_ALLOCA 1
#define HAVE_ALLOCA_H
#define HAVE_ASPRINTF 1
#define HAVE_ATEXIT 1
#define HAVE_BUILTIN_EXPECT 1
#define HAVE_CFLOCALECOPYCURRENT 1
#define HAVE_CFPREFERENCESCOPYAPPVALUE 1
#define HAVE_DECL_CLEARERR_UNLOCKED 1
#define HAVE_DECL_FEOF_UNLOCKED 1
#define HAVE_DECL_FERROR_UNLOCKED 1
#define HAVE_DECL_FFLUSH_UNLOCKED 0
#define HAVE_DECL_FGETS_UNLOCKED 0
#define HAVE_DECL_FPUTC_UNLOCKED 0
#define HAVE_DECL_FPUTS_UNLOCKED 0
#define HAVE_DECL_FREAD_UNLOCKED 0
#define HAVE_DECL_FWRITE_UNLOCKED 0
#define HAVE_DECL_GETCHAR_UNLOCKED 1
#define HAVE_DECL_GETC_UNLOCKED 1
#define HAVE_DECL_GETENV 1
#define HAVE_DECL_PUTCHAR_UNLOCKED 1
#define HAVE_DECL_PUTC_UNLOCKED 1
#define HAVE_DECL_STRDUP 1
#define HAVE_DECL_STRERROR_R 1
#define HAVE_DECL_WCWIDTH 1
#define HAVE_DECL__SNPRINTF 0
#define HAVE_DECL__SNWPRINTF 0
#define HAVE_DLFCN_H 1
#define HAVE_FWPRINTF 1
#define HAVE_GETCWD 1
#define HAVE_GETEGID 1
#define HAVE_GETEUID 1
#define HAVE_GETGID 1
#define HAVE_GETOPT_H 1
#define HAVE_GETOPT_LONG_ONLY 1
#define HAVE_GETPAGESIZE 1
#define HAVE_GETUID 1
#define HAVE_ICONV 1
#define HAVE_INTMAX_T 1
#define HAVE_INTTYPES_H 1
#define HAVE_INTTYPES_H_WITH_UINTMAX 1
#define HAVE_ISWCNTRL 1
#define HAVE_ISWPRINT 1
#define HAVE_LANGINFO_CODESET 1
#define HAVE_LC_MESSAGES 1
#define HAVE_LIMITS_H 1
#define HAVE_LONG_DOUBLE 1
#define HAVE_LONG_LONG_INT 1
#define HAVE_MBRTOWC 1
#define HAVE_MBSTATE_T 1
#define HAVE_MEMCHR 1
#define HAVE_MEMMOVE 1
#define HAVE_MEMORY_H 1
#define HAVE_MMAP 1
#define HAVE_MUNMAP 1
#define HAVE_POSIX_PRINTF 1
#define HAVE_PTHREAD_MUTEX_RECURSIVE 1
#define HAVE_PTHREAD_RWLOCK 1
#define HAVE_PUTENV 1
#define HAVE_READLINK 1
#define HAVE_SETENV 1
#define HAVE_SETLOCALE 1
#define HAVE_SNPRINTF 1
#define HAVE_STDBOOL_H 1
#define HAVE_STDDEF_H 1
#define HAVE_STDINT_H 1
#define HAVE_STDINT_H_WITH_UINTMAX 1
#define HAVE_STDLIB_H 1
#define HAVE_STPCPY 1
#define HAVE_STRCASECMP 1
#define HAVE_STRDUP 1
#define HAVE_STRERROR 1
#define HAVE_STRERROR_R 1
#define HAVE_STRINGS_H 1
#define HAVE_STRING_H 1
#define HAVE_STRTOL 1
#define HAVE_STRTOUL 1
#define HAVE_SYS_PARAM_H 1
#define HAVE_SYS_STAT_H 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_TSEARCH 1
#define HAVE_UINTMAX_T 1
#define HAVE_UNISTD_H 1
#define HAVE_UNSETENV 1
#define HAVE_UNSIGNED_LONG_LONG 1
#define HAVE_UNSIGNED_LONG_LONG_INT 1
#define HAVE_VISIBILITY 1
#define HAVE_WCHAR_H 1
#define HAVE_WCHAR_T 1
#define HAVE_WCSLEN 1
#define HAVE_WCTYPE_H 1
#define HAVE_WCWIDTH 1
#define HAVE_WINT_T 1
#define HAVE__BOOL 1
#define ICONV_CONST const
#define INSTALLPREFIX "/usr/local"
#define INTDIV0_RAISES_SIGFPE 0
#define MALLOC_0_IS_NONNULL 1
#define PACKAGE "gettext-runtime"
#define PACKAGE_BUGREPORT ""
#define PACKAGE_NAME ""
#define PACKAGE_STRING ""
#define PACKAGE_TARNAME ""
#define PACKAGE_VERSION ""
#define STDC_HEADERS 1
#define USE_POSIX_THREADS 1
#define USE_UNLOCKED_IO 1
#define VERSION "0.16.1"
#define VOID_UNSETENV 1
#ifndef _GNU_SOURCE
# define _GNU_SOURCE 1
#endif
#ifndef _POSIX_PTHREAD_SEMANTICS
# define _POSIX_PTHREAD_SEMANTICS 1
#endif
#ifndef _TANDEM_SOURCE
# define _TANDEM_SOURCE 1
#endif
#define __GETOPT_PREFIX rpl_
#define realpath rpl_realpath
#define __libc_lock_t                   gl_lock_t
#define __libc_lock_define              gl_lock_define
#define __libc_lock_define_initialized  gl_lock_define_initialized
#define __libc_lock_init                gl_lock_init
#define __libc_lock_lock                gl_lock_lock
#define __libc_lock_unlock              gl_lock_unlock
#define __libc_lock_recursive_t                   gl_recursive_lock_t
#define __libc_lock_define_recursive              gl_recursive_lock_define
#define __libc_lock_define_initialized_recursive  gl_recursive_lock_define_initialized
#define __libc_lock_init_recursive                gl_recursive_lock_init
#define __libc_lock_lock_recursive                gl_recursive_lock_lock
#define __libc_lock_unlock_recursive              gl_recursive_lock_unlock
#define glthread_in_use  libintl_thread_in_use
#define glthread_once_call            libintl_once_call
#define glthread_once_singlethreaded  libintl_once_singlethreaded
EOF

cd intl

cat libgnuintl.h.in \
| sed -e '/IN_LIBGLOCALE/d' \
      -e 's,@''HAVE_POSIX_PRINTF''@,1,g' \
      -e 's,@''HAVE_ASPRINTF''@,1,g' \
      -e 's,@''HAVE_SNPRINTF''@,1,g' \
      -e 's,@''HAVE_NEWLOCALE''@,1,g' \
      -e 's,@''HAVE_WPRINTF''@,0,g' \
| sed -e 's/extern \([^"]\)/extern LIBINTL_DLL_EXPORTED \1/' \
      -e "/#define _LIBINTL_H/r ./export.h" \
| sed -e 's,@''HAVE_VISIBILITY''@,1,g' \
  > libgnuintl.h

cat libgnuintl.h \
| sed -e '/IN_LIBGLOCALE/d' \
      -e 's,@''HAVE_POSIX_PRINTF''@,1,g' \
      -e 's,@''HAVE_ASPRINTF''@,1,g' \
      -e 's,@''HAVE_SNPRINTF''@,1,g' \
      -e 's,@''HAVE_WPRINTF''@,0,g' \
  > libintl.h
