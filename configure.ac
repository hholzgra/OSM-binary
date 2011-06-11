dnl Process this file with autoconf to produce a configure script.
AC_INIT(osmpbf, 1.1.1j2)

dnl Required autoconf version
AC_PREREQ(2.61)

dnl use automake to generate standard Makefiles
AM_INIT_AUTOMAKE([1.9.6])

dnl Additional macro definitions are in here
AC_CONFIG_MACRO_DIR([m4])

dnl Find C++ compiler
AC_PROG_CXX

dnl Make sure we have libtool installed
AM_PROG_LIBTOOL

dnl Generate Makefile
AC_OUTPUT(Makefile src/Makefile tools/Makefile include/Makefile include/osmpbf/osmpbf.h)
