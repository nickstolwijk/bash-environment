#!/bin/bash

searchterm=$1
find . -type f -iname "*.jar" -print0 | while IFS= read -r -d $'\0' line; do
	if jar -tvf $line | grep $searchterm; then
        echo $line
    fi
done
