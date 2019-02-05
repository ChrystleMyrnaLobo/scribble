# Working with networked machine
Remote: server ip `10.1.2.3` and user `chrystle` alias as `viz`. Following commands are run from local  

## Passworless SSH
- File `/etc/hosts`, alias the hostname
```
10.1.2.3 viz
```
- File `~/.ssh`, mention user
```
Host viz
	User chrystle
```
- For passwordless ssh, generate key-pairs 
```
ssh-keygen
ssh-copy-id -i ~/.ssh/id_rsa.pub viz
```

## Sync files
- Good old scp (secure copy)
```
scp -r foo_dir viz:~/downloads
```
- Faster rsync
```
# Use foo_dir/ for content of foo_dir
# Use foo_dir to copy the dir and contents within

# dry run: 
rsync -avn foo_dir viz:~/downloads

# actual data
#rsync -avzh foo_dir viz:~/downloads
```
