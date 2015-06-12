#!/bin/bash

searchterm=$1
find . -type f -iname "*.jar" -print0 | while IFS= read -r -d $'\0' line; do
     md5sum $line | grep $searchterm 
done
find . -type f -name "artifact*.jar" -print0 | while IFS= read -r -d $'\0' line; do
     if unzip -q -c $line | grep -q $searchterm; then
        echo $line
         unzip -q -c $line | grep -A2 -B4 $searchterm;
     fi
done
find . -type f -name "artifact*.xml" -print0 | while IFS= read -r -d $'\0' line; do
     if grep -q $searchterm $line; then
        echo $line
        grep -A2 -B4 $searchterm $line
     fi
done

