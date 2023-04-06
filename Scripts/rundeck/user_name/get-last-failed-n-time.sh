#!/bin/bash
#############################################
echo "This Script queries failed jobs on N hours, days, etc (please see docs recentFilter)."
echo "Please fill the following:"
#############################################
#############################################
echo "Rundeck Server hostname:"; read -r rundeckServer
echo -e "\nRundeck username:"; read -r rundeckUser
echo -e "\nRundeck password:"; read -r rundeckPass
echo -e "\nRundeck Project:"; read -r rundeckProjectName
echo -e "\nHow much time do you want to filter?:"; read -r timeFilter
#############################################
# to run unatended mode, please comment the code above and uncomment the code below, and replace with your props
#############################################
# rundeckServer="http://localhost:4440"
# rundeckUser="admin"
# rundeckPass="admin"
# rundeckProjectName="Project"
# timeFilter="1d"
#############################################
# Options Variables
#############################################
curlOptions="-s"
cookie="cookie"
#############################################
rundeckApiVersion="23"
rundeckApiFormat="json"
rundeckJobFormat="yaml"
#############################################

curl "$curlOption" -X "POST" -d "j_username=$rundeckUser" -d "j_password=$rundeckPass" -c cookie -b cookie "$rundeckServer"/j_security_check

for jobID in $(curl "$curlOption" -X "GET" -b "$cookie" -c "$cookie" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" "$rundeckServer/api/"$rundeckApiVersion"/project/"$rundeckProjectName"/jobs" | sed 's/,/\n/g' | grep id | cut -d ":" -f2 | tr -d '"')
do
curl "$curlOption" -X "GET" -b "$cookie" -c "$cookie" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" "$rundeckServer/api/"$rundeckApiVersion"/project/"$rundeckProjectName"/executions?statusFilter=failed&recentFilter=$timeFilter&max=1&jobIdListFilter=$jobID" | jq .
done

rm -f "$cookie"