#!/bin/bash

rundeckServer="http://tam-test-95976867.us-east-2.elb.amazonaws.com/rundeck"
rundeckToken="LMfHOAodAtZTQo45z1Ws6viUjkkLMaz4"
#rundeckUser="rundeckuser"
#rundeckPass="DqcmCATnM+/wyWUf5-VBD#9Dv$$jTB"

#curl -s -X "POST" -d "j_username=$rundeckUser" -d "j_password=$rundeckPass" -c cookie -b cookie "$rundeckServer"/j_security_check

mkdir -p templates

for n in {0001..0100};
do
	echo
	sed 's/XXXX/'$n'/g' template.aclpolicy > templates/rundeckRole$n.aclpolicy
	curl -X "POST" -H "Accept: application/yaml" -H "Content-Type: application/yaml" -H "X-Rundeck-Auth-Token: $rundeckToken" "$rundeckServer"/api/30/system/acl/rundeckRole$n.aclpolicy -T templates/rundeckRole$n.aclpolicy
	rm -f templates/rundeckRole$n.aclpolicy
done

#rm -f cookie
rm -rf templates
