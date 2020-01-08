#!/usr/bin/env bash
fileSize=+1G

function bigfile(){
  echo -e "File Size set to $fileSize"
  echo -e "Searching in $1"
  find $1 -size $fileSize -type f -print |xargs ls -lhs 2>/dev/null
}


