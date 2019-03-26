# Working with networked machine
Remote: server ip `10.1.2.3` and user `chrystle` alias as `viz`. Following commands are run from local  

## Clean and neat SSH
- File `/etc/hosts`, alias the hostname
```
10.1.2.3 viz
```
- File `~/.ssh/config`, mention user
```
Host viz
	User chrystle
```
- For passwordless ssh
  - Generate key-pairs `ssh-keygen`. Keep defaults.
  - Copy public key to server `ssh-copy-id -i ~/.ssh/id_rsa.pub viz`
- Test login as `ssh viz`

## Sync files
- Good old scp (secure copy)
```
scp -r foo_dir viz:~/downloads
```
- Faster rsync
```
# Use foo_dir/ for content of foo_dir
# Use foo_dir to copy the dir and contents within

# dry run 
rsync -avn foo_dir viz:~/downloads

# actual data transfer
#rsync -avzh foo_dir viz:~/downloads
```

## Temporary port forwarding
- Redirect connections to the portA on local to portB of server
```
ssh -L portA:remotenode:portB user@remotenode -N
```
- Open `http://localhost:portA/`
- Specific example: Redirects all connections to the port 8080 on your local machine to 80 port of your remote machine. Access `http://192.168.0.10:8080/`
```
ssh -L 192.168.0.10:8080:10.0.0.10:80 root@10.0.0.10
```

## Logging executions
Log an execution (compute loss on test data for all snapshot models) and parse the log to make summary of run.
- Use `2>&1 | tee output/log.txt` to intercept the data stream from stdout to the screen, and save it to a file
- From log file, pick lines which have model name and loss via `grep`. Join two adjacent line together via `paste`. Using `awk` print the 7th and 18th field using the default delimiter of space.
```
grep -E 'Test net output|Finetuning' log/plot_test.log | paste -d " " - - | awk '/caffe.cpp/ { print $7 ","  $18}'  > log/summary.csv
```
- Sample output after grep
```
I0219 11:42:24.067281 25045 caffe.cpp:155] Finetuning from snapshot/mobilenet_plot_iter_10250.caffemodel
I0219 11:46:02.713234 25045 solver.cpp:546]     Test net output #0: detection_eval = 0.606889
```
- More [parse log]

## Install without root access
- Install the software in user directory and update path correspondingly. Usually `PATH` and/or `LD_LIBRARY_PATH`
- Pretty print env vars (print each path on newline)
```
sed 's/:/\n/g' <<< "$PATH"
sed 's/:/\n/g' <<< "$LD_LIBRARY_PATH"
```

## Setup gcc in user directory
- Set up a directory `$GCC_HOME`
```
mkdir $GCC_HOME
```
- Download the required GCC version from releases http://gcc.gnu.org/
```
cd ~/Downloads
tar -xf gcc-5.5.0.tar.gz 

mkdir gcc-build
cd gcc-build
../gcc-5.5.0/configure --prefix=$GCC_HOME
make
make install
```
- Add to `~/.bashrc` for global use
```
export LD_LIBRARY_PATH=$GCC_HOME/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export LD_LIBRARY_PATH=$GCC_HOME/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

export LD_RUN_PATH=$GCC_HOME/lib64${LD_RUN_PATH:+:${LD_RUN_PATH}}
export LD_RUN_PATH=$GCC_HOME/lib${LD_RUN_PATH:+:${LD_RUN_PATH}}
```
- Refer [install gcc]


[parse log]:https://www.loggly.com/ultimate-guide/analyzing-linux-logs/
[install gcc]:https://www.hongliangjie.com/2012/07/20/how-to-install-gcc-higher-version-in-alternative-directory/
