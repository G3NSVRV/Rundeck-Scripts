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
rundeckApiVersion="17"
rundeckApiFormat="json"
rundeckJobFormat="yaml"
#############################################
for keyUrl in $(curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -H "X-Rundeck-Auth-Token: $rundeckApiToken" "$rundeckServer"/api/"$rundeckApiVersion"/storage/keys|sed 's/,/\n/g'|grep url|sed 's/.*http/http/g'|tr -d '"')
do
echo "$keyUrl"
done
