# Proxy setting for IIT D intranet
Word of advice : Do not use special characters (@,:,.,/) in passwords, because escaping may not work always :(

## Linux machine with admin access
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
export HTTP_PROXY="http://10.10.78.62:3128/"
export HTTPS_PROXY="https://10.10.78.62:3128/"
export http_proxy=${HTTP_PROXY}
export https_proxy=${HTTPS_PROXY}
```

## Proxy for conda
```
conda config --set proxy_servers.http http://id:pw@address:port
conda config --set proxy_servers.https https://id:pw@address:port
```

## Proxy for pip
Using package url
```
pip install --ignore-installed --upgrade packageURL --proxy="http://10.10.78.62:3128/"
```

## Proxy for git
```
git config --global http.proxy http://proxyuser:proxypwd@proxy.server.com:8080
```

## Proxy for cmake
`cmake` use its `curl` for download which may not use proxy. So add `--system-curl` option after exporting proxy vars.

## Proxy for curl
```
curl -x http://10.10.78.62:3128 http://url
```
