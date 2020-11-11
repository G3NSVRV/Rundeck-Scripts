#!/bin/bash

rundeckServer="http://node01.rundeck.local:4440"
rundeckUser="user1"
rundeckPass="user"
rundeckApiversion="34"
contentFormat="application/json"
projectName="Project"

curl -v -X "POST" -d "j_username=$rundeckUser" -d "j_password=$rundeckPass" -c cookie -b cookie "$rundeckServer"/j_security_check
