#!/bin/bash
#############################################
echo "Rundeck Server hostname:"; read -r rundeckServer
echo -e "\nRundeck API token:"; read -r rundeckApiToken
# echo -e "\nRundeck username:"; read -r rundeckUser
# echo -e "\nRundeck password:"; read -r rundeckPass
#############################################
# to run unatended mode, please comment the code above and uncomment the code below, and replace with your props
#############################################
# rundeckServer="http://localhost:4440"
# rundeckApiToken="XXXXXXXXX"
# rundeckUser="admin"
# rundeckPass="admin"
#############################################
# Options Variables
#############################################
curlOptions="-s"
cookie="cookie"
#############################################
rundeckApiVersion="17"
rundeckApiFormat="json"
rundeckACLFormat="yaml"
#############################################

#curl "$curlOptions" -X "POST" -d "j_username=$rundeckUser" -d "j_password=$rundeckPass" -c "$cookie" -b "$cookie" "$rundeckServer"/j_security_check

mkdir -p templates

for n in {0001..0100};
do
	echo
	sed 's/XXXX/'$n'/g' template.aclpolicy > templates/rundeckRole$n.aclpolicy
	curl "$curlOptions" -X "POST" -H "Accept: application/$rundeckACLFormat" -H "Content-Type: application/$rundeckACLFormat" -H "X-Rundeck-Auth-Token: $rundeckApiToken" "$rundeckServer"/api/"$rundeckApiVersion"/system/acl/rundeckRole$n.aclpolicy -T templates/rundeckRole$n.aclpolicy
	rm -f templates/rundeckRole$n.aclpolicy
done

#rm -f "$cookie"
rm -rf templates
