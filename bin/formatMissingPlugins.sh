#!/bin/bash
while IFS=' ' read -ra dep; do 
    echo "<plugin>"
    echo "   <groupId>org.apache.maven.plugins</groupId>"
    echo "   <artifactId>${dep[1]}</artifactId>"
    echo "   <version>${dep[3]}</version>"
    echo "</plugin>"
done < /tmp/missingPlugins.txt 
