#!/bin/bash
#############################################
# echo "Rundeck Server hostname:"; read -r rundeckServer
# echo -e "\nRundeck username:"; read -r rundeckUser
# echo -e "\nRundeck password:"; read -r rundeckPass
#############################################
# to run unatended mode, please comment the code above and uncomment the code below, and replace with your props
#############################################
rundeckServer="http://node01-linux.local:4440"
rundeckUser="admin"
rundeckPass="admin"
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

for projectName in $(curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -c "$cookie" -b "$cookie" "$rundeckServer"/api/"$rundeckApiVersion"/projects|sed 's/,/\n/g'| grep name | cut -d ":" -f2 | tr -d '"')
do
scmImport=$(curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -c "$cookie" -b "$cookie" "$rundeckServer"/api/"$rundeckApiVersion"/project/"$projectName"/scm/import/plugins | jq '{"type":.plugins[].type,"enabled":.plugins[].enabled}')
scmExport=$(curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -c "$cookie" -b "$cookie" "$rundeckServer"/api/"$rundeckApiVersion"/project/"$projectName"/scm/export/plugins | jq '{"type":.plugins[].type,"enabled":.plugins[].enabled}')

if [ -n "$(echo $scmImport | grep -o '"enabled": true')" ]
then
echo SCM Import Works
fi
if [ -n "$(echo $scmExport | grep -o '"enabled": true')" ]
then
echo SCM Export Works
fi
done

rm -f "$cookie"
