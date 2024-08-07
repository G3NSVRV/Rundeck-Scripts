#!/bin/bash
#############################################
echo "Rundeck Server hostname:"; read -r rundeckServer
echo -e "\nRundeck username:"; read -r rundeckUser
echo -e "\nRundeck password:"; read -r rundeckPass
echo -e "\nProject Name:"; read -r projectName
#############################################
# to run unatended mode, please comment the code above and uncomment the code below, and replace with your props
#############################################
# rundeckServer="http://localhost:4440"
# rundeckUser="admin"
# rundeckPass="admin"
# projectName="test"
#############################################
# Options Variables
#############################################
curlOptions="-s"
cookie="cookie"
#############################################
rundeckApiVersion="34"
rundeckApiFormat="json"
#############################################

curl "$curlOptions" -X "POST" -d "j_username=$rundeckUser" -d "j_password=$rundeckPass" -c "$cookie" "$rundeckServer"/j_security_check

#for projectName in $(curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -b "$cookie" -c "$cookie" "$rundeckServer"/api/"$rundeckApiVersion"/projects|sed 's/,/\n/g'| grep name | cut -d ":" -f2 | tr -d '"')
#do
#curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -b "$cookie" -c "$cookie" "$rundeckServer"/api/"$rundeckApiVersion"/project/"$projectName"/executions?"recentFilter=5n&max=20" | jq .
#curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -b "$cookie" -c "$cookie" "$rundeckServer"/api/"$rundeckApiVersion"/project/"$projectName"/executions/running?"max=20" | jq .
#curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -b "$cookie" -c "$cookie" "$rundeckServer"/api/"$rundeckApiVersion"/project/"$projectName"/executions/metrics?"recentFilter=1d" | jq .
curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -b "$cookie" -c "$cookie" "$rundeckServer"/api/"$rundeckApiVersion"/system/info | jq .
#done

rm -f "$cookie"
