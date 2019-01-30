## Caffe + Conda + Ubuntu + GPU + No admin access
- Setup cuda and cudnn w/o admin acess [cuda]
- Setup caffe [caffe] 
  - Before running `make`:  
In file `CMakeLists.txt` line 62 (or after the last 'set' of CMAKE_CXX_FLAG) add this line   
`set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")`
  - Modify `cmake` command as  
  `cmake -DBLAS=open -DCUDNN_INCLUDE=$CUDA_HOME/include/ -DCUDNN_LIBRARY=$CUDA_HOME/lib64/libcudnn.so -DCMAKE_PREFIX_PATH=$ENV_PATH -DCMAKE_INSTALL_PREFIX=$ENV_PATH -DCUDA_CUDART_LIBRARY=$CUDA_HOME/lib64/libcudart.so -D CUDA_TOOLKIT_ROOT_DIR=$CUDA_HOME ..
`

[cuda]: https://jin-zhe.github.io/guides/installing-caffe-with-cuda-on-anaconda/
[caffe]: https://jin-zhe.github.io/guides/installing-caffe-with-cuda-on-anaconda/
