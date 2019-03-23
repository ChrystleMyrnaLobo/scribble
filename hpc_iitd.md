# Workflow to use the HPC at IIT Delhi</br>
http://supercomputing.iitd.ac.in/   

Disclaimer: This is very limited tutorial based on what I needed to get started. Use for hitchhiking.

## 1. Login via Kerberos (intranet only)
- Open new terminal, `ssh mcs991234@hpc.iitd.ac.in`
- Current working directory (command `pwd`) should be `/home/cse/mtech/mcs991234`
- Passwordless ssh while working with [remote machines on network]

## 2. Set up environment and internet access (one-time)
### Default user environment
Use the default user environment provided by HPC
```
cp /home/apps/skeleton/.bashrc $HOME/.bashrc
cp /home/apps/skeleton/.bash_profile $HOME/.bash_profile
```
### Link to scratch folder (with 100TB)
```
ln -s $SCRATCH $HOME/scratch
```
### Make your folder inaccessible to all
```
chmod og-rx $SCRATCH
chmod og-rx $HOME 
```

### Internet access from login node (as per required)
- Use CA certificate `export SSL_CERT_FILE=$HOME/mycerts/CCIITD-CA.crt`
- Proxy login `lynx https://proxy62.iitd.ernet.in/cgi-bin/proxy.cgi` or open `firefox` and login to proxy.
- Log in to HPC to *same* login node. Set env variables
```
export http_proxy="http://10.10.78.62:3128/"
export https_proxy="https://10.10.78.62:3128/"
```
- More on [proxy]

## 3. Load softwares
### A. Use HPC-maintained software
- Find path to the required module using command (lists available modules) `module avail`. Search module as `module keyword tensorflow`/
- To load python in the environment, (use path, here python3), `module load compiler/python/3.6.0/ucs4/gnu/447`
- For more python packages (like numpy, pandas etc), use a suite or individually load. Loading a suite for python3 by `module load pythonpackages/3.6.0/ucs4/gnu/suite1`

### B. Download from the internet
- These are only for the ones which do not require admin access.
- Example: Download minconda setup script from the site (`Miniconda3-latest-Linux-x86_64.sh` and run `bash Miniconda3-latest-Linux-x86_64.sh`

## 4. Transfer files from local to remote
- Open terminal at the parent directory of the folder/file to be transfered
- Move directory `cat` to remote folder `~/dataset` using `scp -r cat mcs991234@hpc.iitd.ac.in:~/dataset`. 
- Check the transfer at remote by `ls ~/dataset/cat`
- Reverse steps to transfer from remote to local machine
- More on working with [remote machines on network]

## 5. Use PBS
- HPC uses PBS (portable batch system) for ditributed workload management. PBS accepts an executable shell script (aka job).
### Create job
- Create a file `pbsbatch.sh` as [pbsbatch.sh]. Here showTFVersion.py is an executable python file.
- Note the `qsub` options are mentioned in the shell script itself, to make a clean command line command.

### Submit job
- Make script executable `chmod +x pbsbatch.sh`
- Submit script by command `qsub pbsbatch.sh`. This return `653106.hn1.hpc.iitd.ac.in` where 653106 is the Job ID.

### Check status of job
- Check the status of the job `qstat -u mcs991234`

### Reference:
- http://supercomputing.iitd.ac.in/?access
- http://supercomputing.iitd.ac.in/?pbs
- Not IITD resource, but is a better resource than the official one http://hpcugent.github.io/vsc_user_docs/pdf/intro-HPC-windows-gent.pdf

[proxy]:https://github.com/ChrystleMyrnaLobo/scribble/blob/master/proxy_iitd.md
[pbsbatch.sh]:https://github.com/ChrystleMyrnaLobo/scribble/blob/master/pbsbatch.sh
[remote machines on network]:https://github.com/ChrystleMyrnaLobo/scribble/blob/master/networkServer.md
