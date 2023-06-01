#!/usr/bin/env bash

##Security scripts

function dockerFile(){
   for i in $(find . -name Dockerfile 2>/dev/null);do echo "$i $(cat $i | grep FROM)";done
}
