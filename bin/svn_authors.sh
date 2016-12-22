#!/bin/sh

repo=$1 

LANG=C svn log -q $repo | grep -e '^r' | awk 'BEGIN { FS = "|" } ; { print $2 }' | sort | uniq |
while read author;
do
  echo "${author} = NAME <USER@DOMAIN>";
done
