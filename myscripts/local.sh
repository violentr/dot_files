#!/usr/bin/env bash

pyenv global 3.10.0

function external_ip(){
  #curl http://checkip.amazonaws.com
  curl --silent https://jsonip.com/ | python -c "import sys; import json; out=sys.stdin.read(); print(json.loads(out)['ip'])"
}
echo -e "[+]Your external ip"
external_ip

# Check port <address> <port>
port_info(){
  echo "Port is open" || echo "Port is closed" || echo "Connection timeout"
}

check_port() {
  for app in nc curl telnet gtimeout timeout
  do
		if [ "$(which $app)" != "" ]; then
			tool=$app
      break
    else
			tool=devtcp
		fi
	done

	echo "Using '$tool' to test access to $1:$2"
	case $tool in
		nc) nc -v -G 5 -z -w2 $1 $2 ;;
		curl) curl -s --connect-timeout 10 http://$1:$2 ;;
		telnet) telnet $1 $2 ;;
		gtimeout)  gtimeout 1 bash -c "</dev/tcp/${1}/${2}" && port_info;;
		timeout)  timeout 1 bash -c "</dev/tcp/${1}/${2}" && port_info;;
		devtcp)  <"/dev/tcp/${1}/${2}" && port_info;;
		*) echo "no tools available to test $1 port $2";;
	esac
}

settingsMySQL(){
  echo $(mysql -Nse "SELECT CONCAT(@@datadir, @@general_log_file)")
}

function killport() {
  lsof -i TCP:$1 | awk '/LISTEN/ {print $2}' | xargs kill -9
  echo -e "[+] Current Listen ports"
  netstat -ant |grep LISTEN
}

function compileCS(){
  echo -e "$1"
  csc Program.cs Person.cs MyEnums.cs Utitlities.cs
  # run csharp compiled programm
  #mono Program.exe
}

function hugeFiles(){
  find ~ -type f -size +1G -exec ls -lh {} \; 2>/dev/null | awk '{ print $9 $10 ": " $5 }' | tee big-size-files.txt
}
