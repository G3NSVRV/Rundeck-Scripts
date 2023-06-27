#!/bin/bash
#############################################
echo "Rundeck Server hostname:"; read -r rundeckServer
echo -e "\nRundeck API token:"; read -r rundeckApiToken
#############################################
# to run unatended mode, please comment the code above and uncomment the code below, and replace with your props
#############################################
# rundeckServer="http://localhost:4440"
# rundeckApiToken="XXXXXXXXX"
#############################################
# Options Variables
#############################################
curlOptions="-s"
#############################################
rundeckApiVersion="19"
rundeckApiFormat="json"
rundeckJobFormat="yaml"
#############################################
tokensFolder="tokens"
#############################################

echo
echo "-----------"
mkdir -p "$tokensFolder"

for tokenID in $(curl -X "GET" "$curlOptions" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -H "X-Rundeck-Auth-Token: $rundeckApiToken" "$rundeckServer"/api/"$rundeckApiVersion"/tokens|sed 's/,/\n/g'|grep id|cut -d ":" -f2|tr -d '"')
do
curl -X "GET" "$curlOptions" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -H "X-Rundeck-Auth-Token: $rundeckApiToken" "$rundeckServer"/api/"$rundeckApiVersion"/token/"$tokenID" > "$tokensFolder"/"$tokenID".token
if [ -f ./"$tokensFolder"/"$tokenID".token ];
then
echo 'exported ./'"$tokensFolder"'/'"$tokenID"'.token'
else
echo 'there was an error exporting the token "'"$tokenID"'"'
fi
done

echo "-----------"
echo
echo '[All tokens were exported to "'"$tokensFolder"'" Folder]'