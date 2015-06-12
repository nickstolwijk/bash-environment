#!/bin/bash

searchterm=$1
find . -type f -iname "*.jar" -print0 | while IFS= read -r -d $'\0' line; do
     echo $line
     jar -tvf $line | grep $searchterm 
     #echo Manifest search
     #unzip -p $line META-INF/MANIFEST.MF | grep $searchterm
done
