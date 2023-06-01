#!/usr/bin/env bash

#Code review tool
# Handmade SAST

input=$1
output=code_review_o
scripts_folder="$HOME/dot_files/myscripts"

cleanup(){
  echo "[+] Cleaning old files"
  [[ -f $output ]] && rm $output && echo "[+] File $output was removed"
}

for i in  $(ls $(pwd) |grep $output)
do
  echo "[!] Old versions of codereview reports were discovered"
  rm -i "$i"
done

codeAudit(){
  echo -e "Code review in progress, searching for patterns \n"
  while IFS= read -r line
  do
    echo -e "[+] Looking for pattern: $line\n" |tee -a $output
    eval $line |tee -a $output
    echo -e "\n" |tee -a $output
  done < "$sourceFile"
}

cleanup

if [ -z "$1" ]
then
  echo "Exit"
  exit 1
else
  case $input in
    spring)
      echo "[+] Run JAVA SPRING";
      output="$output"_java_spring.txt;
      sourceFile="$scripts_folder/g_java_spring.txt";
      codeAudit;;
    javascript)
      echo "Run Javascript" ;
      output="$output"_javascript.txt;
      sourceFile="$scripts_folder/g_javascript.txt";
      codeAudit;;
    **)
      echo "Exit";
      exit 1;
  esac

  echo -e "[+] File was created: $output"
fi
