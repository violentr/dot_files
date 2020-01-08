#!/usr/bin/env bash

from_date=$1
to_date=$2
reponame=$3

output_file=scope_of_work.txt
report_file=github_report.txt
company=

#how to use the script
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 'start_date' 'end_date' reponame"
  echo "Example: $0 'YYYY/MM/DD' 'YYYY/MM/DD' infosec"
  exit 1
fi

git status &>/dev/null
if [ "$?" -ne 0 ]; then
  echo -e "[-] There is no git repo"
  exit 1
fi

#clean up previous search
#remove files associated with it.
[[ -f $output_file ]] && rm $output_file && echo "[+] Remove file $output_file"
[[ -f $report_file ]] && rm $report_file && echo "[+] Remove file $report_file"

echo "[+] Collecting data from the git log"
echo "[+] Current dir $(pwd)"

echo -e "[+] Search Git Log From: $from_date To: $to_date"
git log --stat --since "$from_date" --until "$to_date" --oneline | grep "Merge pull" | tee $output_file &>/dev/null

echo "[+] Creating Report, please wait"
while IFS= read -r line; do
  path="https://github.com/$company/$reponame/pull"
  number="$( echo -e "$line" | awk -F" " '{print $5}' |cut -b 2- )"
  branch_name="$( echo -e "$line" | awk -F"$company/" '{print $2}')"

  echo -e "$path/$number $branch_name" | tee -a $report_file &>/dev/null
done < $output_file

if [ -f $report_file ]; then
  echo "[+] Report was generated, saved to ./$report_file"
else
  echo "[-] Something went wrong try again, output file was not created"
  echo "[-] No data for the period you specifiied, try to increase date range"
fi
