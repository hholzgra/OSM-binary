lib_LTLIBRARIES = libosmpbf.la

libosmpbf_la_SOURCES = fileformat.pb.cc fileformat.pb.h osmformat.pb.cc osmformat.pb.h
libosmpbf_la_LIBADD = -lprotobuf
libosmpbf_la_LDFLAGS = -version-info 1:0:1


pkginclude_HEADERS = fileformat.pb.h osmformat.pb.h

%.pb.o: %.pb.cc
	$(CXX) $(CXXFLAGS) -c -o $@ $<

%.pb.cc ../include/osmpbf/%.pb.h: %.proto
	protoc --proto_path=. --cpp_out=. $<

