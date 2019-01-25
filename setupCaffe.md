## Caffe + Conda + Ubuntu + GPU + No admin access
Follow tutorial:
`https://jin-zhe.github.io/guides/installing-caffe-with-cuda-on-anaconda/` 

Before running `make`:  
+ In file `CMakeLists.txt` line 62 (or after the last 'set' of CMAKE_CXX_FLAG) add this line   
`set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")`
