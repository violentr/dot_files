#!/usr/bin/env bash
# Snyk code scanning and reporting

function snyk_tests(){
## Credit: Winfred
  dirname=${PWD##*/}
  commit_name=${dirname}_$(git rev-parse --short=8 HEAD)
  commit_name=$(echo $commit_name | sed 's/\///g')

  echo "Current Commit[${commit_name}]"
  echo "[+] Running snyk scans... (SCA, SAST)"

  snyk test --all-projects > ${commit_name}.sca
  snyk code test > ${commit_name}.sast
  echo "[+] Opening results"

  subl ${commit_name}.sca
  subl ${commit_name}.sast
  open .
}

function process_snyk(){
  if [ -f "snyk.output" ]
  then
    echo "[+] Links were saved to file: snyk.output \n"
    echo "[+] Snyk parser report started"
    $HOME/dot_files/myscripts/snyk_report.py

    echo "[+] Printing Critical severity vulnerabilities"
    cat snyk.report | grep Critical | cut -d "|" -f3 | tee -a snyk.critical.report

    echo "[+] Printing High severity vulnerabilities"
    cat snyk.report | grep High | cut -d "|" -f3 | tee -a snyk.high.report

    echo "[+] Printing Medium severity vulnerabilities"
    cat snyk.report | grep Medium | cut -d "|" -f3 | tee -a snyk.medium.report

    echo "[+] Printing Low severity vulnerabilities"
    cat snyk.report | grep Low | cut -d "|" -f3 | tee -a snyk.low.report
  else
    echo "[+] SCA: No vulnerable libraries found!"
  fi
}

function snyk_report(){
  output="snyk.list"
  rm snyk.*
  snyk test  --all-projects --json | jq '.[].vulnerabilities[].id' | tee -a $output
  #snyk test  --json | jq '.[1].vulnerabilities[].id' | tee -a $output
  cat $output | sort |uniq | tee -a snyk.results

  while read line
  do
    line=$(echo $line | tr -d "\"") > /dev/null
    cond=$(echo $line | grep -E "SNYK-[A-Z]{2,13}")

    if [[ ! -z $cond  ]]
    then
      echo "https://security.snyk.io/vuln/$line" | tee -a  snyk.output
    fi
  done < snyk.results
  process_snyk
}

function snyk_nested(){
  output="snyk.list"
  rm snyk.*
  snyk test --maven-aggregate-project --json | jq '.[].vulnerabilities[].id' | tee -a $output
  cat $output | sort |uniq | tee -a snyk.results

  while read line
  do
    line=$(echo $line | tr -d "\"") > /dev/null
    cond=$(echo $line | grep -E "SNYK-[A-Z]{2,13}")

    if [[ ! -z $cond  ]]
    then
      echo "https://security.snyk.io/vuln/$line" | tee -a  snyk.output
    fi
  done < snyk.results
  process_snyk
}

function scans() {
  output="trivy_scan.results"
  echo "[!] Previous scans results cleaning"
  rm *.sast *.sca $output

  snyk_tests
  echo -e "\n"

  if [[ ! -z $output ]]
  then
    echo "[+]Trivy: Scan in progress .."
    trivy fs . | tee -a $output
    echo "[+]Trivy: Output was saved to: $output"
  fi
}
