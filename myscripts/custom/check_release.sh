#!/usr/bin/env bash
# Check code change between from and to commits
# Open relevant files in sublime editor for further inspection

from="$1"
to="$2"
url=""

#full_check(){
#  if [ $# -eq 2 ]
#  then
#    bc_repo="$(git remote -v | cut -d ':' -f2 | grep -Eo '^[^\.]{1,100}' | head -n 1)"
#    url="https://gitlab.com/$bc_repo/-/compare?from=$from&to=$to"
#    echo "[+] Compare Url: $url"
#
#    output_file=release_code_review.txt
#    git diff --name-status $from $to| sort -u |  tee -a $output_file
#    #  git diff --name-status $from $to| sort -u | grep "main/java" | tee -a $output_file
#
#    echo -e "[+] Open modified files in sublime editor"
#
#    for file in "$(cat $output_file)"
#    do
#      subl $file
#    done
#  else
#    echo -e "[!] Error [from] and [to] commits must be present"
#    exit 1
#  fi
#
#  open $url
#}
#

if [ $# -eq 2 ]
then
  bc_repo="$(git remote -v | cut -d ':' -f2 | grep -Eo '^[^\.]{1,100}' | head -n 1)"
  url="https://gitlab.com/$bc_repo/-/compare?from=$from&to=$to"
  echo "[+] Compare Url: $url"

  output_file=release_code_review.txt
  git diff --name-status $from $to| sort -u |  tee -a $output_file
  #  git diff --name-status $from $to| sort -u | grep "main/java" | tee -a $output_file
else
  echo -e "[!] Error [from] and [to] commits must be present"
  exit 1
fi

open $url


