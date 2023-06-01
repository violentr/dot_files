#!/usr/bin/env bash
#
#  1. Download JS files (list of files must be provided)
#  2. Beautify them for the analyses
#  3. Save output to file
#

inputFile=$1

if [ $# -eq 0 ]
then
  echo -e "[-] Input file must be provided !"
  exit
fi

while read line
do
  echo -e "[+] Downloading current file $line"
  wget $line

  fileName=$(echo $line | grep -Eo "\w{1,10}(-\w{1,10})?\.\w{1,30}\.js")
  echo -e "[+] Beautify file: $fileName"

  js-beautify $fileName > "$(pwd)/processed/chk-$fileName"
done < $inputFile
