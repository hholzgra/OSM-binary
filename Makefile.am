# autotools setup
ACLOCAL_AMFLAGS = -I m4


# library and headers

lib_LTLIBRARIES = libosmpbf.la

nodist_libosmpbf_la_SOURCES = src/fileformat.pb.cc include/osmpbf/fileformat.pb.h src/osmformat.pb.cc include/osmpbf/osmformat.pb.h
libosmpbf_la_LIBADD = -lprotobuf
libosmpbf_la_LDFLAGS = -version-info 1:0:1

nodist_pkginclude_HEADERS = include/osmpbf/osmpbf.h include/osmpbf/fileformat.pb.h include/osmpbf/osmformat.pb.h



# protoc processing

AM_CXXFLAGS = -I include/osmpbf

EXTRA_DIST = src/fileformat.proto src/osmformat.proto

CLEANFILES = src/fileformat.pb.cc include/osmpbf/fileformat.pb.h src/osmformat.pb.cc include/osmpbf/osmformat.pb.h

src/fileformat.pb.cc include/osmpbf/fileformat.pb.h: src/fileformat.proto
	mkdir -p src
	protoc --proto_path=$(srcdir)/src --cpp_out=$(builddir)/src $<
	mv src/fileformat.pb.h include/osmpbf

src/osmformat.pb.cc include/osmpbf/osmformat.pb.h: src/osmformat.proto
	mkdir -p src
	protoc --proto_path=$(srcdir)/src --cpp_out=src $<
	mv src/osmformat.pb.h include/osmpbf



# binaries

bin_PROGRAMS = osmpbf-outline

osmpbf_outline_SOURCES   = tools/osmpbf-outline.cpp
osmpbf_outline_CXX_FLAGS = @ZLIB_CFLAGS@ @PROTOBUF_LITE_CFLAGS@
osmpbf_outline_LDFLAGS   = @ZLIB_LDFLAGS@ @ZLIB_LIBS@ @PROTOBUF_LITE_LDFLAGS@ @PROTOBUF_LITE_LIBS@ -losmpbf

dist_man_MANS = tools/osmpbf-outline.1



# Debian package specific rules

deb:
	debuild -I -us -uc

deb-src: 

	debuild -S -sa

deb-clean:

	debuild clean