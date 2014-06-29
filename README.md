This is a basic implementation of the Bag of (Visual) Words approach (BoW) for image retrieval.
It may not be enough for academic research while the state of the arts have already been developed far from BoW, but may be a good start point if you want to build your own indexing for personal photos, etc.

## Compilation

The code relies on OpenCV with non-free module compiled (mainly for SIFT feature).
Configure `pkg-config` for OpenCV and you are good to go.
A tutorial about compiling OpenCV with non-free module and also configuring `pkg-config` can be found [here](http://www.ozbotz.org/opencv-installation/). (If you only need to build non-free modules, many steps are not necessary)

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
