# Setup environment for TensorFlow Objection detection API for GPU (or IITD HPC)

## LabelImg
- Used for annotation according to PASCAL VOC standard
https://github.com/tzutalin/labelImg

## Conda 
- Download latest minconda setup script from the site (say, `Miniconda3-latest-Linux-x86_64.sh` and run `bash Miniconda3-latest-Linux-x86_64.sh`
- One Time Create python env for all python libraries used in the project `conda create -n py35 python=3.5`
- Activate the env, `source activate py35` and deactivate env by `source deactivate`

## Tensorflow
### On project server
- Refer [tensorflow object detection api setup](http://tensorflow-object-detection-api-tutorial.readthedocs.io/en/latest/install.html#tensorflow-gpu)
- To install protobuf on Ubuntu
```
# Make sure you grab the latest version
curl -OL https://github.com/google/protobuf/releases/download/v3.2.0/protoc-3.2.0-linux-x86_64.zip

# Unzip
unzip protoc-3.2.0-linux-x86_64.zip -d protoc3

# Move protoc to /usr/local/bin/
sudo mv protoc3/bin/* /usr/local/bin/

# Move protoc3/include to /usr/local/include/
sudo mv protoc3/include/* /usr/local/include/

# Optional: change owner
sudo chwon [user] /usr/local/bin/protoc
sudo chwon -R [user] /usr/local/include/google
```

### IITD HPC 
These steps will be done during job (Note: Write a script to do this)
- Find the module from `module keyword tensorflow` and load as `module load apps/tensorflow/1.5.0/gpu`.
- We need cuda, cuDNN, python and tensorflow for Object detection API
- CUDA is a parallel computing platform and application programming interface model created by Nvidia
- The NVIDIA CUDA Deep Neural Network library (cuDNN) is a GPU-accelerated library of primitives for deep neural networks.
- Check install location of CUDA tootkit `nvcc --version` and check if it is added in the required environment variables (pretty print) 
```
sed 's/:/\n/g' <<< "$PATH"
sed 's/:/\n/g' <<< "$LD_LIBRARY_PATH"
```
- Find and load protobuf `module load apps/protobuf/3.2.0/gnu`
- Protocol Buffers (protobuf) are Google's language-neutral, platform-neutral, extensible mechanism for serializing structured data.
- Find and load Pillow for PIL `module load pythonpackages/2.7.13/pillow/5.1.0/gnu`

## Jupyter 
### Remote access to jupyter notebook
- On remote server, start Jupyter server (`--no-browser` for not opening browser) on a desired port (`--port=XXXX`) here 8889 
```
jupyter notebook --no-browser --port=8889
```
- On local machine, open an SSH tunnel with port forwarding option `-L` to forward the port on remote (`XXXX`) to desired port on local (`YYYY` here 8888). 
``` 
ssh -N -f -L localhost:8888:localhost:8889 remote_user@remote_host
```
- `-f` puts the ssh tunnel in background. To close it, find the process `ps aux | grep localhost:XXXX` and kill it `kill -15 18418`
- `-N` tells SSH that no remote commands will be executed
- Open browser to `localhost:8888`. Need to open with token for thr first time

### Reference: 
- https://conda.io/miniconda.html
- http://tensorflow-object-detection-api-tutorial.readthedocs.io/en/latest/install.html#tensorflow-gpu
- https://www.pyimagesearch.com/2017/09/27/setting-up-ubuntu-16-04-cuda-gpu-for-deep-learning-with-python/
- https://gist.github.com/sofyanhadia/37787e5ed098c97919b8c593f0ec44d8
- https://coderwall.com/p/ohk6cg/remote-access-to-ipython-notebooks-via-ssh
- https://help.ubuntu.com/stable/ubuntu-help/nautilus-connect.html.en
