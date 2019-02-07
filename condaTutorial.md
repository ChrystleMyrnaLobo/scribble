# Conda tutorial
Some common conda commands I frequently use (and yet forget)

## Create environment
- Fresh env `conda create --name myenv`  
- From `.yml` file `conda env create -f environment.yml`

## Use environment
Activate `conda activate myenv`
Deactivate `conda deactivate`

## Display
- All envs `conda env list`
- All packages in the curretly active env `conda list`

## Set environment variables for env
- In `anaconda3/envs/myenv`
```
mkdir -p ./etc/conda/activate.d
mkdir -p ./etc/conda/deactivate.d
touch ./etc/conda/activate.d/env_vars.sh
touch ./etc/conda/deactivate.d/env_vars.sh
```
- Activate
```
#!/bin/sh

export PYTHONPATH=$HOME/caffe/python:$PYTHONPATH
```
- Deativate
```
#!/bin/sh

unset PYTHONPATH
```

## Export environment
Save the environment as  `conda env export > environment.yml`

## Remove environment
`conda remove --name myenv --all`

### References
https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#activating-an-environment
