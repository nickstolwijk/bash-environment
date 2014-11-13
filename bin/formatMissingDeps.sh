#!/bin/bash
while IFS=' :' read -ra dep; do 
    echo "<dependency>"
    echo "   <groupId>${dep[1]}</groupId>"
    echo "   <artifactId>${dep[2]}</artifactId>"
    echo "   <version>${dep[4]}</version>"
    echo "   <scope>${dep[5]}</scope>"
    echo "</dependency>"
done < /tmp/missing_deps.txt 
