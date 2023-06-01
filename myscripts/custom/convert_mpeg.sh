#! /usr/bin/env bash
#file=$1

files=$(find . -type f -name '*.ts')
for i in $files ; do  ffmpeg -i $i -acodec copy -vcodec copy $i.mp4 ;done

#ffmpeg -i $1 -acodec copy -vcodec copy out.mps4
