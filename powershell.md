# Power Shell for Linux users

## Commands same as linux
`Tab` key works a bit different 

```
cd Downloads
cd ..

pwd

ls Downloads
ls

cat foo.txt

diff foo.txt boo.txt

mv a.txt b.txt
cp a.txt b.txt
```

### grep
PowerShell uses `Select-String` with explict argument
```
Select-String -Pattern "matplotlib" requirements.txt
Select-String -Path *.py -Pattern "main"
```

[101]: https://developer.rackspace.com/blog/powershell-101-from-a-linux-guy
