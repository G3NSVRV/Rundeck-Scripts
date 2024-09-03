#!/bin/bash
#############################################
echo "Rundeck Server hostname:"; read -r rundeckServer
echo -e "\nRundeck username:"; read -r rundeckUser
echo -e "\nRundeck password:"; read -r rundeckPass
#echo -e "\nProject Name:"; read -r projectName
#echo -e "\nJob ID:"; read -r jobID
#############################################
# to run unatended mode, please comment the code above and uncomment the code below, and replace with your props
#############################################
# rundeckServer="http://localhost:4440"
# rundeckUser="admin"
# rundeckPass="admin"
# projectName="test"
# jobID="null"
#############################################
# Options Variables
#############################################
curlOptions="-s"
cookie="cookie"
#############################################
rundeckApiFormat="json"
#############################################

curl "$curlOptions" -X "POST" -d "j_username=$rundeckUser" -d "j_password=$rundeckPass" -c "$cookie" "$rundeckServer"/j_security_check

curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -b "$cookie" -c "$cookie" "$rundeckServer"/api/44/userclass/allocations | jq .

rm -f "$cookie"
