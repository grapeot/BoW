This is a basic implementation of the Bag of (Visual) Words approach (BoW) for image retrieval.
It may not be enough for academic research while the state of the arts have already been developed far from BoW, but may be a good start point if you want to build your own indexing for personal photos, etc.

Since this repo uses `git submodule`, you may want to clone it with `git clone --recursive https://github.com/grapeot/BoW`.

## Compilation

The code relies on OpenCV with non-free module compiled (mainly for SIFT feature).
Configure `pkg-config` for OpenCV and you are good to go.
An example bash snippet based on Debian sid is available below. 
If you're eager to learn about all the details, a tutorial about compiling OpenCV with non-free module and also configuring `pkg-config` can be found [here](http://www.ozbotz.org/opencv-installation/). 

```bash
sudo apt-get build-essential cmake pkg-config libgtk2.0-dev python-dev python-numpy
sudo apt-get install libpng12-0 libpng12-dev libpng++-dev libpng3 libpnglite-dev zlib1g-dbg zlib1g zlib1g-dev pngtools libjasper-dev libjasper-runtime libjasper1 libjpeg8 libjpeg8-dbg libjpeg62 libjpeg62-dev libjpeg-progs libtiff4 libtiffxx0c2 libtiff-tools libavcodec-dev libavformat-dev libswscale-dev openexr libopenexr6 libopenexr-dev
wget http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/2.4.2/OpenCV-2.4.2.tar.bz2
tar xvjf OpenCV-2.4.2.tar.bz2
cd OpenCV-2.4.2
mkdir release
cd release
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D BUILD_ZLIB=ON -D BUILD_PYTHON_SUPPORT=ON ..
make -j 12
sudo make install
sudo echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf
sudo ldconfig -v
cat << EOF >> ~/.zshrc
PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH
EOF
source ~/.zshrc
cd ../..
```

It has been tested under Debian Wheezy, but currently not supporting MacOS.
It shouldn't been hard to be converted to Windows, but I've never tried that.

## Usage

`index` will extract features, using approximate KMeans to learn the dictionary, store the dictionary as `dict.dat`.
The features will then be (hard) quantized accordingly, sum pooled, L1 normalized, and then stored as `bows.dat`.

`search` will extract features from the input image, quantize, pool, and then do retrieval from the `bows.dat`. 
The result ranking will be output to `stdout`.
If a list of image file names is given, it will also visualize the result into an HTML file named `result.html`.

## Technical Details

* Sparse DoG + SIFT
* Approximate KMeans based on KDTree
* Hard (approximate) quantization based on KDTree
* Sum pooling
* L1 normalization on BoW vectors
* Histogram Intersection Kernel
* Most of the operations are accelerated with OpenMP

The optimization enables the system to support relatively large image database, e.g. tens of thousands of images, with million size codebook.

## Future Work

1. Implement the Bow vector as sparse ones.
2. Make the output more flexible.
