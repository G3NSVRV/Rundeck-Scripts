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

for projectName in $(curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -H "X-Rundeck-Auth-Token: $rundeckApiToken" rundeckServer/api/"$rundeckApiVersion"/projects|sed 's/,/\n/g'| grep name | cut -d ":" -f2 | tr -d '"')
do
echo "Project $projectName"
curl "$curlOptions" -X "GET" -H "Accept: application/zip" -H "Content-Type: application/zip" -H "X-Rundeck-Auth-Token: $rundeckApiToken" rundeckServer/api/"$rundeckApiVersion"/project/"$projectName"/executions/running
echo 
jobId=$(curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -H "X-Rundeck-Auth-Token: $rundeckApiToken" rundeckServer/api/"$rundeckApiVersion"/project/"$projectName"/executions?max=1|sed 's/,/\n/g'|grep executions|cut -d ":" -f3)
echo -e "Last Job ID $jobId\n"
done
