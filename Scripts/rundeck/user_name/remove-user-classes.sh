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
apiVersion="44"
apiFormat="json"
#############################################

curl "$curlOptions" -X "POST" -d "j_username=$rundeckUser" -d "j_password=$rundeckPass" -c "$cookie" -b "$cookie" "$rundeckServer"/j_security_check

echo
echo "Loading User Classes..."

userClassesArray=$(echo '{"bulkRemove":true,"usernames":['$(curl "$curlOptions" -X "GET" -H "Content-Type: application/$apiFormat" -H "Accept: application/$apiFormat" -c "$cookie" -b "$cookie" "$rundeckServer"/api/"$apiVersion"/userclass/allocations | jq -r '.allocations | keys | map("\"" + . + "\"") | join(",")')']}')

echo "$userClassesArray" | jq .
echo
echo "Removing User Classes..."

curl "$curlOptions" -X "POST" -H "Content-Type: application/$apiFormat" -H "Accept: application/$apiFormat" -c "$cookie" -b "$cookie" "$rundeckServer"/api/"$apiVersion"/userclass/update -d "$userClassesArray" | jq .

echo "User Classes Removed Successfully"

rm -f "$cookie"
