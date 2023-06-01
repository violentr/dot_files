#!/usr/bin/env bash
#
#  1. Download JS webpack files (list of files must be provided)
#  2. Beautify them for the analyses
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

  fileName=$(echo $line | ack -o --match "(polyfills|commons|vendor|legacy|(?<=/)app\.|(?<=/)([0-9]{1,3}\.)).*")

  #wget $line


  echo -e "[+] WebPack-Unpack file: $fileName"
  webpack-unpack < $fileName > "$(pwd)/processed/chk-$fileName"

  echo -e "[+] Beautify file: $fileName"
  js-beautify "$(pwd)/processed/chk-$fileName" > chk-$filename
done < $inputFile
