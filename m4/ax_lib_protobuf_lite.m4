# SYNOPSIS
#
#   AX_LIB_PROTOBUF_LITE()
#
# DESCRIPTION
#
#   This macro provides tests of availability of the lite
#   version of the protobuf library. This macro checks for 
#   libprotobuf-lite headers and libraries and defines compilation 
#   and linker flags flags
#
#   Macro supports following options and their values:
#
#   1) Single-option usage:
#
#     --with-protobuf-lite -- yes, no, or path to protobuf-lite library 
#                             installation prefix
#
#   2) Three-options usage (all options are required):
#
#     --with-protobuf-lite=yes
#     --with-protobuf-lite-inc  -- path to base directory with protobuf-lite headers
#     --with-protobuf-lite-lib  -- linker flags for protobuf-lite
#
#   This macro calls:
#
#     AC_SUBST(PROTOBUF_LITE_CFLAGS)
#     AC_SUBST(PROTOBUF_LITE_LDFLAGS)
#     AC_SUBST(PROTOBUF_LITE_LIBS)
#
#   And sets:
#
#     HAVE_PROTOBUF_LITE
#
# LICENSE
#
#   Copyright (c) 2009 Hartmut Holzgraefe <hartmut@php.net>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AX_LIB_PROTOBUF_LITE],
[
    AC_ARG_WITH([protobuf-lite],
        AC_HELP_STRING([--with-protobuf-lite=@<:@ARG@:>@],
            [use protobuf-lite library from given prefix (ARG=path); check standard prefixes (ARG=yes); disable (ARG=no)]
        ),
        [
        if test "$withval" = "yes"; then
            if test -f /usr/local/include/google/protobuf/stubs/common.h ; then
                protobuf_lite_prefix=/usr/local
            elif test -f /usr/include/google/protobuf/stubs/common.h ; then
                protobuf_lite_prefix=/usr
            else
                protobuf_lite_prefix=""
            fi
            protobuf_lite_requested="yes"
        elif test -d "$withval"; then
            protobuf_lite_prefix="$withval"
            protobuf_lite_requested="yes"
        else
            protobuf_lite_prefix=""
            protobuf_lite_requested="no"
        fi
        ],
        [
        dnl Default behavior is implicit yes
        if test -f /usr/local/include/google/protobuf/stubs/common.h ; then
            protobuf_lite_prefix=/usr/local
        elif test -f /usr/include/google/protobuf/stubs/common.h ; then
            protobuf_lite_prefix=/usr
        else
            protobuf_lite_prefix=""
        fi
        ]
    )

    AC_ARG_WITH([protobuf-lite-inc],
        AC_HELP_STRING([--with-protobuf-lite-inc=@<:@DIR@:>@],
            [path to protobuf-lite library headers]
        ),
        [protobuf_lite_include_dir="$withval"],
        [protobuf_lite_include_dir=""]
    )
    AC_ARG_WITH([protobuf-lite-lib],
        AC_HELP_STRING([--with-protobuf-lite-lib=@<:@ARG@:>@],
            [link options for protobuf-lite library]
        ),
        [protobuf_lite_lib_flags="$withval"],
        [protobuf_lite_lib_flags=""]
    )

    PROTOBUF_LITE_CFLAGS=""
    PROTOBUF_LITE_LDFLAGS=""

    dnl
    dnl Collect include/lib paths and flags
    dnl
    run_protobuf_lite_test="no"

    if test -n "$protobuf_lite_prefix"; then
        protobuf_lite_include_dir="$protobuf_lite_prefix/include"
        protobuf_lite_lib_flags="-L$protobuf_lite_prefix/lib"
        protobuf_lite_lib_libs="-lprotobuf-lite"
        run_protobuf_lite_test="yes"
    elif test "$protobuf_lite_requested" = "yes"; then
        if test -n "$protobuf_lite_include_dir" -a -n "$protobuf_lite_lib_flags" -a -n "$protobuf_lite_lib_libs"; then
            run_protobuf_lite_test="yes"
        fi
    else
        run_protobuf_lite_test="no"
    fi

    dnl
    dnl Check protobuf_lite files
    dnl
    if test "$run_protobuf_lite_test" = "yes"; then

        saved_CPPFLAGS="$CPPFLAGS"
        CPPFLAGS="$CPPFLAGS -I$protobuf_lite_include_dir"

        saved_LDFLAGS="$LDFLAGS"
        LDFLAGS="$LDFLAGS $protobuf_lite_lib_flags -lpthread"

        saved_LIBS="$LIBS"
        LIBS="$LIBS $protobuf_lite_lib_libs"

        dnl
        dnl Check protobuf-lite headers
        dnl
        AC_MSG_CHECKING([for protobuf-lite headers in $protobuf_lite_include_dir])

        AC_LANG_PUSH([C++])
        AC_COMPILE_IFELSE([
            AC_LANG_PROGRAM(
                [[
@%:@include <google/protobuf/stubs/common.h>
                ]],
                [[]]
            )],
            [
            PROTOBUF_LITE_CFLAGS="-I$protobuf_lite_include_dir"
            protobuf_lite_header_found="yes"
            AC_MSG_RESULT([found])
            ],
            [
            protobuf_lite_header_found="no"
            AC_MSG_RESULT([not found])
            ]
        )
        AC_LANG_POP([C++])

        dnl
        dnl Check protobuf-lite libraries
        dnl
        if test "$protobuf_lite_header_found" = "yes"; then

            AC_MSG_CHECKING([for protobuf-lite library])

            AC_LANG_PUSH([C++])
            AC_LINK_IFELSE([
                AC_LANG_PROGRAM(
                    [[
@%:@include <google/protobuf/stubs/common.h>
                    ]],
                    [[
google::protobuf::ShutdownProtobufLibrary();		 
                    ]]
                )],
                [
                PROTOBUF_LITE_LDFLAGS="$protobuf_lite_lib_flags"
                PROTOBUF_LITE_LIBS="$protobuf_lite_lib_libs"
                protobuf_lite_lib_found="yes"
                AC_MSG_RESULT([found])
                ],
                [
                protobuf_lite_lib_found="no"
                AC_MSG_RESULT([not found])
                ]
            )
            AC_LANG_POP([C++])
        fi

        CPPFLAGS="$saved_CPPFLAGS"
        LDFLAGS="$saved_LDFLAGS"
        LIBS="$saved_LIBS"
    fi

    AC_MSG_CHECKING([for protobuf-lite library])

    if test "$run_protobuf_lite_test" = "yes"; then
        if test "$protobuf_lite_header_found" = "yes" -a "$protobuf_lite_lib_found" = "yes"; then
            AC_SUBST([PROTOBUF_LITE_CFLAGS])
            AC_SUBST([PROTOBUF_LITE_LDFLAGS])
            AC_SUBST([PROTOBUF_LITE_LIBS])
            AC_SUBST([HAVE_PROTOBUF_LITE])

            AC_DEFINE([HAVE_PROTOBUF_LITE], [1],
                [Define to 1 if protobuf-lite library is available])

            HAVE_PROTOBUF_LITE="yes"
        else
            HAVE_PROTOBUF_LITE="no"
        fi

        AC_MSG_RESULT([$HAVE_PROTOBUF_LITE])


    else
        HAVE_PROTOBUF_LITE="no"
        AC_MSG_RESULT([$HAVE_PROTOBUF_LITE])

        if test "$protobuf_lite_requested" = "yes"; then
            AC_MSG_WARN([protobuf-lite support requested but headers or library not found. Specify valid prefix of protobuf-lite using --with-protobuf-lite=@<:@DIR@:>@ or provide include directory and linker flags using --with-protobuf-lite-inc and --with-protobuf-lite-lib])
        fi
    fi
])

