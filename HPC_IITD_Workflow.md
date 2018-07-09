# Workflow to use the HPC at IIT Delhi</br>
http://supercomputing.iitd.ac.in/   

Disclaimer: This is very limited tutorial based on what I needed to get started. Use for hitchhiking.

## 1. Login via Kerberos (intranet only)
- Open new terminal, `ssh mcs991234@hpc.iitd.ac.in`
- You'll see prompt `-bash-4.1$`. Type command `bash`
- Current working directory (command `pwd`) should be `/home/cse/mtech/mcs991234`

## 2. Set up environment and internet access
### Default user environment
Use the default user environment provided by HPC
```
cp /home/apps/skeleton/.bashrc $HOME/.bashrc`
cp /home/apps/skeleton/.bash_profile $HOME/.bash_profile
```

### Internet access
- Admin access is not provided for HPC users. So we need to setup proxy for internet access everytime by `export http_proxy="http://10.10.78.62:3128/"` and `export https_proxy="https://10.10.78.62:3128/"`
- One Time:  Download script `proxy.sh` (from this repo) for proxy login. Edit the file to add you login credentials and check the proxy hostname. Transfer to the HPC remote machine. Change file permission `chmod 755 proxy.sh`.
- Run in the background `./proxy.sh &`

## 3. Load softwares
### A. Use HPC-maintained software
- Find path to the required module using command (lists available modules) `module avail`
- To load python in the environment, (use path, here python3), `module load compiler/python/3.6.0/ucs4/gnu/447`
- For more python packages (like numpy, pandas etc), use a suite or individually load. Loading a suite for python3 by `module load pythonpackages/3.6.0/ucs4/gnu/suite1`

### B. Download from the internet
- Example: Download minconda setup script from the site (`Miniconda3-latest-Linux-x86_64.sh` and run `bash Miniconda3-latest-Linux-x86_64.sh`

## 4. Transfer files from local to remote
- Open terminal at the parent directory of the folder/file to be transfered
- Move directory `cat` to remote folder `~/dataset` using `scp -r cat mcs991234@hpc.iitd.ac.in:~/dataset`. 
- Check the transfer at remote by `ls ~/dataset/cat`
- Reverse steps to transfer from remote to local machine

### Reference:
- http://supercomputing.iitd.ac.in/?access
- https://hpcc.usc.edu/gettingstarted/
