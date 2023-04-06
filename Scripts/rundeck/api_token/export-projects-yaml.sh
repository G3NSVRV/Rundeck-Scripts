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
mkdir -p exported_projects

for projectName in $(curl -X "GET" "$curlOptions" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -H "X-Rundeck-Auth-Token: $rundeckApiToken" "$rundeckServer"/api/"$rundeckApiVersion"/projects|sed 's/,/\n/g'| grep name | cut -d ":" -f2 | tr -d '"')
do
mkdir -p exported_projects/"$projectName"
mkdir -p exported_projects/"$projectName"/jobs
curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -H "X-Rundeck-Auth-Token: $rundeckApiToken" "$rundeckServer"/api/"$rundeckApiVersion"/project/"$projectName"/config > exported_projects/"$projectName"/"$projectName".project
for jobId in $(curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -H "X-Rundeck-Auth-Token: $rundeckApiToken" "$rundeckServer"/api/"$rundeckApiVersion"/project/"$projectName"/jobs | sed 's/,/\n/g' | grep id | cut -d ":" -f2 | tr -d '"')
do
curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckJobFormat" -H "Content-Type: application/$rundeckJobFormat" -H "X-Rundeck-Auth-Token: $rundeckApiToken" "$rundeckServer"/api/"$rundeckApiVersion"/job/"$jobId" > exported_projects/"$projectName"/jobs/"$jobId".yaml;
done
done

echo -e "\n[ Please go to ""exported_projects"" folder ]"
