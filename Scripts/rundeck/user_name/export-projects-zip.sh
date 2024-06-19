#!/bin/bash
#############################################
echo "Rundeck Server hostname:"; read -r rundeckServer
echo -e "\nRundeck username:"; read -r rundeckUser
echo -e "\nRundeck password:"; read -r rundeckPass
#############################################
# to run unatended mode, please comment the code above and uncomment the code below, and replace with your props
#############################################
# rundeckServer="http://localhost:4440"
# rundeckUser="admin"
# rundeckPass="admin"
#############################################
# Options Variables
#############################################
curlOptions="-s"
cookie="cookie"
#############################################
rundeckApiVersion="34"
rundeckApiFormat="json"
rundeckProjectFormat="zip"
options="exportAll=false"
options="$options&exportJobs=true"
options="$options&exportExecutions=false"
options="$options&exportConfigs=true"
options="$options&exportReadmes=true"
options="$options&exportAcls=true"
options="$options&exportScm=true"
options="$options&exportWebhooks=true"
options="$options&whkIncludeAuthTokens=true"
#### 4.4.0 snapshot
options="$options&exportComponents.calendars=true"
options="$options&exportComponents.Schedule%20Definitions=true"
options="$options&exportComponents.tours-manager=true"
options="$options&exportComponents.node-wizard=true"
#############################################
echo "Downloading data..."
mkdir -p exported_projects

curl "$curlOptions" -X "POST" -d "j_username=$rundeckUser" -d "j_password=$rundeckPass" -c "$cookie" -b "$cookie" "$rundeckServer"/j_security_check

for projectName in $(curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -c "$cookie" -b "$cookie" "$rundeckServer"/api/"$rundeckApiVersion"/projects|sed 's/,/\n/g'| grep name | cut -d ":" -f2 | tr -d '"')
do
curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckProjectFormat" -H "Content-Type: application/$rundeckProjectFormat" -c "$cookie" -b "$cookie" "$rundeckServer"/api/"$rundeckApiVersion"/project/"$projectName"/export?"$options" > exported_projects/"$projectName".jar
done
echo -e "\n[ Please go to ""exported_projects"" folder ]"

rm -f "$cookie"
