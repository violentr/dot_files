#!/usr/bin/env bash
#https://aquasecurity.github.io/trivy/v0.27.1/docs/references/cli/fs/

function trivy_scan(){
  trivy fs . --format json | jq '.Results[].Vulnerabilities[].References' | grep "SNYK-JS" | tr -d "\"" | tr -d "," > snyk.output
  process_snyk
  trivy_secrets
}


function trivy_legacy(){
  rm snyk.*
  trivy fs . --format json | jq '.Results[].Vulnerabilities[].References' | grep SNYK | tr -d "\"," | tee -a snyk.output

  snyk_report.py
  echo -e "[+] Printing Critical Severity vulnerabilities"
  cat snyk.report | grep Critical | cut -d "|" -f3

  echo -e "[+] Printing High Severity vulnerabilities"
  cat snyk.report | grep High | cut -d "|" -f3

  echo -e "[+] Printing Medium Severity vulnerabilities"
  cat snyk.report | grep Medium | cut -d "|" -f3
}

function trivy_secrets(){
  rm *.secrets
  filename=project.secrets
  trivy fs . | tee -a trivy.secrets
  cat trivy.secrets | grep secrets -A 5 | tr -d "==" | tee -a $filename
}
