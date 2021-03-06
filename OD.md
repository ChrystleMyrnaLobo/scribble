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

# From TensorFlow/models/research/
protoc object_detection/protos/*.proto --python_out=.
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

## Coco API
- Clone the [cocoapi](https://github.com/cocodataset/cocoapi) 
- Ensure cython is present. Install the API
```
$ cd coco/PythonAPI
$ make
$ sudo make install
$ sudo python setup.py install
```
- Install dependecies, if not present
- Add this folder on `$PYTHONPATH`. In `~/.bashrc` add `/home/chrystle/MTP/cocoapi/PythonAPI`

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


# Custom object detector training
### Setup folders
In a new folder for the dataset, set up workspace as follows
- Data: Contain the `.csv` and TFRecord `.record` for train and validation set.
- Images: Contains the images 
- preTrainModel: Unziped content of the model chosen from model zoo  `tar -xzvf ssd_mobilenet_v1_coco.tar.gz`
- training: The checkpoints generated during training will be stored here.
- Copy `model_main.py` from `model/research/object_detection/` to the folder.

### Configure training pipeline
- Create `label_map.pbtxt` in Data folder as (start index from 1)
```
item {
    id: 1
    name: 'dog'
}
item {
    id: 2
    name: 'cow'
}
```
- Copy the pipeline `pipeline.config` from the preTrainModel folder or use sample from `/master/research/object_detection/samples/configs/ssd_mobilenet_v1_coco.config` to training folder. Edit 
  - num_classes : as per label map file
  - fine_tune_checkpoint : to `model.ckpt` in preTrainedModel
  - train_input_reader, eval_input_reader : Path to training TFRecord file and label map file
  
### Tensorboard
- Launch tensorboard and optionally specify the port (default 6006). Open browser to `http://127.0.0.1:6008`. 
```
tensorboard --logdir=/training  --port=6008 &
```
- Use the pid to kill the process `kill -15 18418`
- To view the Tensorboard on local machine, use local port forwarding i.e. use the -L option to transfer the port 6008 of the remote server into the port 16006 of local machine. Open browser to `http://127.0.0.1:16006`. 
```
ssh -L 16006:127.0.0.1:6008 remote_user@remote_host
```

### Train / Transfer learning
- Use the tensorflow's train script to transfer learn. Specify the GPU using `CUDA_VISIBLE_DEVICES`.
```
export CUDA_VISIBLE_DEVICES=1

python models/research/object_detection/model_main.py \
    --pipeline_config_path=training/ssd_mobilenet_v2_coco.config \
    --model_dir=training/
```
Ctrl+C to stop. To resume training, use the same command. The latest checkpoints from model_dir will be used. 

### Export the model
- Choose the appropriate checkpoint (here 13302) and export model
```
python export_inference_graph.py \
--input_type image_tensor \
--pipeline_config_path training/ssd_inception_v2_coco.config \
--trained_checkpoint_prefix training/model.ckpt-13302 \
--output_directory trained-inference-graphs/output_inference_graph_v1.pb
```
- In the object detection code, change MODEL_NAME, PATH_TO_LABELS (path to label map file)  and NUM_CLASSES. Then run prediction

### Legacy train scripts
- Previous version used `train.py`, `eval.py`, `export_inference_grap.py` which are moved to `model/research/object_detection/legacy` folder
```
python train.py --logtostderr \
--train_dir=training/ \
--pipeline_config_path=training/ssd_inception_v2_coco.config
```
Ctrl+C to stop.
- Evaluate model
```
python eval.py --logtostderr \
--pipeline_config_path=training/ssd_inception_v2_coco.config \
--checkpoint_dir=training/ \
--eval_dir=eval
```

### References
- https://github.com/EdjeElectronics/TensorFlow-Object-Detection-API-Tutorial-Train-Multiple-Objects-Windows-10#4-generate-training-data
- https://becominghuman.ai/tensorflow-object-detection-api-tutorial-training-and-evaluating-custom-object-detector-ed2594afcf73
- https://towardsdatascience.com/detailed-tutorial-build-your-custom-real-time-object-detector-5ade1017fd2d
- https://stackoverflow.com/questions/37987839/how-can-i-run-tensorboard-on-a-remote-server
