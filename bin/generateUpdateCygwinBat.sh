#!/bin/sh
echo -n "setup-x86.exe -D -R c:\apps\cygwin-test -p proxy.local:8080 -q -l c:\apps\cygwin-packages -g -A -P " > update.bat
cygcheck -c -d | sed -e "1,2d" -e 's/ .*$//' | awk 'NR==1{printf $1}{printf ",%s", $1}' >> update.bat
