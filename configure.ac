dnl Process this file with autoconf to produce a configure script.
AC_INIT(osmpbf, 1.1.1j3)

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

dnl check for zlib library
AX_LIB_ZLIB
if test "$HAVE_ZLIB" = "no"
then
  AC_MSG_ERROR([required library not found]);
fi

dnl check for protobuf-lite library
AX_LIB_PROTOBUF_LITE
if test "$HAVE_PROTOBUF_LITE" = "no"
then
  AC_MSG_ERROR([required library not found]);
fi


dnl Generate Makefile
AC_OUTPUT(Makefile include/osmpbf/osmpbf.h)
