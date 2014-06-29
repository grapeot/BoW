CC=g++
CFLAGS=-std=c++11 -fopenmp -I.. -O3
ADDCFLAGS=
OPENCV_FLAGS=`pkg-config opencv --cflags` `pkg-config opencv --libs`

all: index search
search: search.cpp BoWBuilder.h
	$(CC) $(CFLAGS) $(ADDCFLAGS) $(OPENCV_FLAGS) search.cpp -o search
index: index.cpp BoWBuilder.h
	$(CC) $(CFLAGS) $(ADDCFLAGS) $(OPENCV_FLAGS) index.cpp -o index 
clean:
	rm index search
