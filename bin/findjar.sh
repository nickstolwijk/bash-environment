#!/bin/sh
#
# findjar.sh by Samuli Kaski
#
 
VERBOSE=no
 
if [ $# -ne 2 ]; then
        echo "Usage: findjar.sh <path> <classname>";
        exit;
fi
 
STARTPATH=$1
CLASS=$2
 
echo "Starting search for JAR files from directory $STARTPATH"
echo "Looking for the class $CLASS"
echo ""
echo "This might take a while..."
echo ""
 
for jar in `find $STARTPATH -name '*.jar'`;
do
 BASENAME=`basename $jar`
 
 jar -tf $jar | grep $CLASS
 
 if [ $? -eq 0 ]; then
 
   echo "$jar"
 fi
done
