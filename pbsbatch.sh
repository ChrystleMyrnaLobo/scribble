#!/bin/sh
### Arguments to qsub
### Set the job name
#PBS -N trialjob
### Set the project name/ your department
#PBS -P cse
### Request email when job begins and ends
#PBS -m bea
### Specify email address to use for notification.
#PBS -M mcs991234@iitd.ac.in
#### Request for <select> number of nodes/slot with <ncpus> cupu and <ngpu> gpu
#PBS -l select=1:ncpus=1:ngpus=1
### Save standard output to file
#PBS -o /home/cse/mtech/mcs991234/trial.out
### Save standard error to 
#PBS -e /home/cse/mtech/mcs991234/trialerr.out

# Job
module load apps/tensorflow/1.5.0/gpu
cd  /home/cse/mtech/mcs991234/MTP
./showTFVersion.py
