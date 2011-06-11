# autotools setup
ACLOCAL_AMFLAGS = -I m4

# general build flags

AM_CXXFLAGS = @ZLIB_CFLAGS@ @PROTOBUF_LITE_CFLAGS@ -I include -I include/osmpbf
AM_LDFLAGS   = @ZLIB_LDFLAGS@ @ZLIB_LIBS@ @PROTOBUF_LITE_LDFLAGS@ @PROTOBUF_LITE_LIBS@ -losmpbf



# library and headers

lib_LTLIBRARIES = libosmpbf.la

nodist_libosmpbf_la_SOURCES = src/fileformat.pb.cc include/osmpbf/fileformat.pb.h src/osmformat.pb.cc include/osmpbf/osmformat.pb.h
libosmpbf_la_LDFLAGS = -version-info 1:0:1

nodist_pkginclude_HEADERS = include/osmpbf/osmpbf.h include/osmpbf/fileformat.pb.h include/osmpbf/osmformat.pb.h



# protoc processing

EXTRA_DIST = src/fileformat.proto src/osmformat.proto

CLEANFILES = src/fileformat.pb.cc include/osmpbf/fileformat.pb.h src/osmformat.pb.cc include/osmpbf/osmformat.pb.h

src/fileformat.pb.cc include/osmpbf/fileformat.pb.h: src/fileformat.proto
	@mkdir -p src
	protoc --proto_path=$(srcdir)/src --cpp_out=$(builddir)/src $(srcdir)/src/fileformat.proto
	@mv src/fileformat.pb.h include/osmpbf

src/osmformat.pb.cc include/osmpbf/osmformat.pb.h: src/osmformat.proto
	@mkdir -p src
	protoc --proto_path=$(srcdir)/src --cpp_out=src $(srcdir)/src/osmformat.proto
	@mv src/osmformat.pb.h include/osmpbf



# binaries

bin_PROGRAMS = osmpbf-outline

osmpbf_outline_SOURCES   = tools/osmpbf-outline.cpp

dist_man_MANS = tools/osmpbf-outline.1



# Debian package specific rules

deb:
	debuild -I -us -uc

deb-src: 

	debuild -S -sa

deb-clean:

	debuild clean