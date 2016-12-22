#!/bin/bash
while IFS=' :' read -ra dep; do 
    echo "<dependency>"
    echo "   <groupId>${dep[6]}</groupId>"
    echo "   <artifactId>${dep[7]}</artifactId>"
    echo "   <version>${dep[9]}</version>"
    echo "   <scope>${dep[10]}</scope>"
    echo "</dependency>"
done < /tmp/missing_deps.txt 
