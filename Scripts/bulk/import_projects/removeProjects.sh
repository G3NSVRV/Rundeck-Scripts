#!/usr/bin/env bash

#rundeckServer="http://tam-test-95976867.us-east-2.elb.amazonaws.com/rundeck"
#rundeckToken="LMfHOAodAtZTQo45z1Ws6viUjkkLMaz4"
#apiVersion="38"
#cookie="cookie"
#curlOpt="-s"
#apiFormat="application/json"
#jobFormat="application/yaml"
#projectPrefix="jgarces"

source config

for n in $(eval echo "{1..$amountProjects}")
do
	n=$(printf %04d $n)
	count=0
	projectName="$projectPrefix-Project$n"

	echo $projectName

	curl "$curlOpt" -X "DELETE" -H "Accept: $apiFormat" -H "Content-Type: $apiFormat" -H "X-Rundeck-Auth-Token: $rundeckToken" "$rundeckServer"/api/"$apiVersion"/project/"$projectName"
done
