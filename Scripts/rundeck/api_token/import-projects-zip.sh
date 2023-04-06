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
rundeckProjectFormat="zip"
options="exportAll=true"
# options="exportJobs=true"
# options="$options&exportExecutions=true"
# options="$options&exportConfigs=true"
# options="$options&exportReadmes=true"
# options="$options&exportAcls=true"
#############################################

projectName="$(echo $1|rev|cut -d "/" -f1|rev|cut -d "-" -f1)"
echo $projectName

curl -s -X "POST" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -H "X-Rundeck-Auth-Token: $rundeckApiToken" "$rundeckServer"/api/"$rundeckApiVersion"/projects -d '{ "name": "'$projectName'" }'|jq

curl -s -X "PUT" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckProjectFormat" -H "X-Rundeck-Auth-Token: $rundeckApiToken" "$rundeckServer"/api/"$rundeckApiVersion"/project/"$projectName"/import -T "$1"|jq