#!/bin/bash
find . -type f -iname "*.jar" -print0 | while IFS= read -r -d $'\0' line; do
	
	 NAME=`echo "$line" | cut -d'.' -f2 | cut -d'/' -f2`
	 echo $line $NAME
     #jar -tvf $line | grep $searchterm 
     unzip $line -d $NAME
done
