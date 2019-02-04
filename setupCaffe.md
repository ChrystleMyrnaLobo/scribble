# Caffe SSD MobileNet w/o root access

## Setup CUDA
- Setup cuda and cudnn [cuda]

## Setup SSD (a caffe fork)
- Clone [ssd] as ssd_caffe. This repo is forked from BVLC/caffe.
- Use caffe branch `git checkout caffe` on ssd_caffe
- Make build directory `mkdir build && cd build`

## Setup Caffe
- Create new conda env  
```
conda create -n ssd python=2.7 anaconda
conda activate ssd
export ENV_PATH=$HOME/anaconda3/envs/ssd
```
- Download dependancies  
`conda install lmdb openblas glog gflags hdf5 protobuf leveldb opencv cmake -y`
- gcc-5.x.x requires -std=c++11, but the boost lib in Debian system are built without such an option. So you need to build your own version of boost. [build boost]
  - Find the version of the current boost lib. `conda list boost`
  - Download the boost lib source file with exactly the same version from https://www.boost.org/.
  - Compile boost with std=c++11 using: `b2 toolset=gcc cxxflags=”-std=c++11”`
  - Copy the generated library to replace the original boost library: `cp boost-1.67.0/stage/lib/* ~/anaconda3/lib/`  
- In file `CMakeLists.txt` (after the last 'set' of CMAKE_CXX_FLAG around line 62) add this line   
`set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")`
- Use `cmake`   
 ```
 cmake -DBLAS=open -DCUDNN_INCLUDE=$CUDA_HOME/include/ -DCUDNN_LIBRARY=$CUDA_HOME/lib64/libcudnn.so -DCMAKE_PREFIX_PATH=$ENV_PATH -DCMAKE_INSTALL_PREFIX=$ENV_PATH -DCUDA_CUDART_LIBRARY=$CUDA_HOME/lib64/libcudart.so -D CUDA_TOOLKIT_ROOT_DIR=$CUDA_HOME ..
 
 make all -j 8
 make install
 ```
- Export `export PYTHONPATH=$HOME/ssd_caffe/python:$PYTHONPATH`. Refer [caffe] to add to conda env.

## Setup SSD MobileNet
- Clone [mobilenet ssd] 
- Uncomment `engine: CAFFE` under `convolution_param` in every convolution layers in `*.prototxt`
- Run `demo.py` 

[ssd]: https://github.com/weiliu89/caffe/tree/ssd
[mobilenet ssd]: https://github.com/chuanqi305/MobileNet-SSD
[cuda]: https://jin-zhe.github.io/guides/installing-caffe-with-cuda-on-anaconda/
[caffe]: https://jin-zhe.github.io/guides/installing-caffe-with-cuda-on-anaconda/
[build boost]: https://github.com/BVLC/caffe/issues/6043#issuecomment-423049323
