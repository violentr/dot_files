#echo "Two params needed: file_name, path to read from"
#[ -z "$var" ] && echo "Empty"

function checkWebsite(){
	www="$(dig $line A +short)"
	[[ -z $www ]] && echo "$line - domain does not exist"
}
function findMatch(){
	grep -Rn --exclude-dir=log --exclude-dir=spec $line .
}

while IFS='' read -r line || [[ -n "$line" ]]; do
  checkWebsite
done < "$1"
