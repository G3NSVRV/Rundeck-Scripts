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
projectName="test"
runnerID="8abf008a-85e4-4d23-ab81-bfb8fe639c9e"
apiVersion=42
curlOptions="-s"
cookie="cookie"
#############################################

curl "$curlOptions" -X "POST" -d "j_username=$rundeckUser" -d "j_password=$rundeckPass" -c "$cookie" -b "$cookie" "$rundeckServer"/j_security_check

#curl "$curlOptions" -X "POST" -H "Content-Type: application/json" -b "$cookie" -c "$cookie" "$rundeckServer"/api/"$apiVersion"/runnerManagement/runners -d '
#{
#  "name": "My Runner",
#  "description": "A runner for running CI/CD pipelines",
#  "assignedProjects": {
#    "project1": ".*",
#    "project2": ".*"
#  },
#  "tagNames": "runner, pipeline, automation"
#}

curl "$curlOptions" -X "POST" -H "Accept: application/json" -b "$cookie" -c "$cookie" "$rundeckServer"/api/"$apiVersion"/runnerManagement/runner/"$runnerID"/regenerateCreds

rm -f "$cookie"
