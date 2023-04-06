#!/bin/bash
#############################################
echo "Rundeck Server hostname:"; read -r rundeckServer
echo -e "\nRundeck username:"; read -r rundeckUser
echo -e "\nRundeck password:"; read -r rundeckPass
echo -e "\nSearch term:"; read -r grepSearch
#############################################
# to run unatended mode, please comment the code above and uncomment the code below, and replace with your props
#############################################
# rundeckServer="http://localhost:4440"
# rundeckUser="admin"
# rundeckPass="admin"
# grepSearch="queue"
#############################################
# Options Variables
#############################################
curlOptions="-s"
cookie="cookie"
#############################################
rundeckApiVersion="17"
rundeckApiFormat="json"
rundeckJobFormat="yaml"
#############################################

echo -e "\n--------- results ---------"

curl -X "POST" "$curlOptions" -d "j_username=$rundeckUser" -d "j_password=$rundeckPass" -c "$cookie" -b "$cookie" "$rundeckServer"/j_security_check

for projectName in $(curl -X "GET" "$curlOptions" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -b "$cookie" "$rundeckServer"/api/"$rundeckApiVersion"/projects|sed 's/,/\n/g'| grep name | cut -d ":" -f2 | tr -d '"')
do
    for jobID in $(curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckApiFormat" -H "Content-Type: application/$rundeckApiFormat" -b "$cookie" "$rundeckServer"/api/"$rundeckApiVersion"/project/"$projectName"/jobs | sed 's/,/\n/g' | grep id | cut -d ":" -f2 | tr -d '"')
    do
        if [ -n "$(curl "$curlOptions" -X "GET" -H "Accept: application/$rundeckJobFormat" -H "Content-Type: application/$rundeckJobFormat" -b "$cookie" "$rundeckServer"/api/"$rundeckApiVersion"/job/"$jobID" | grep "$grepSearch")" ]
        then
            echo "$jobID"
        fi
    done
done

rm -f "$cookie"