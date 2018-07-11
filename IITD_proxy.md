# Proxy setting for IIT D intranet on linux machine 

## With admin access
- In `/etc/environment` add the following lines (62 for mtech)
```
HTTP_PROXY=http://10.10.78.62:3128
HTTPS_PROXY=https://10.10.78.62:3128
FTP_PROXY=http://10.10.78.62:3128
```

- In `/etc/apt/apt.conf` add the line
```
Acquire::http::proxy "http://10.10.78.62:3128/";
```

- In `~/.bashrc`, add lines
```
export http_proxy="http://10.10.78.62:3128/"
export http_proxy="http://10.10.78.62:3128/"
```
