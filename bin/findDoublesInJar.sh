#!/bin/bash


rm /tmp/doubles
find . -type f -iname "*.jar" -print0 | while IFS= read -r -d $'\0' line; do
     jar -tvf $line >> /tmp/doubles 
     jar -tvf $line | grep jar
done

cat /tmp/doubles | awk '{print $8}' | sort | uniq -d -c | grep class
