#!/bin/bash
while IFS=' /' read -ra dep; do 
    echo "<dependency>"
    echo "   <groupId>${dep[0]}</groupId>"
    echo "   <artifactId>${dep[1]}</artifactId>"
    echo "   <version>${dep[2]}</version>"
    echo "</dependency>"
done < /tmp/missing_deps.txt 
