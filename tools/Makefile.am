bin_PROGRAMS = osmpbf-outline

osmpbf_outline_SOURCES   = osmpbf-outline.cpp
osmpbf_outline_CXX_FLAGS = @ZLIB_CFLAGS@ @PROTOBUF_LITE_CFLAGS@
osmpbf_outline_LDFLAGS   = @ZLIB_LDFLAGS@ @ZLIB_LIBS@ @PROTOBUF_LITE_LDFLAGS@ @PROTOBUF_LITE_LIBS@ -L../src -losmpbf

dist_man_MANS = osmpbf-outline.1
