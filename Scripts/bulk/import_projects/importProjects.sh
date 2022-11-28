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

	curl "$curlOpt" -X "POST" -H "Accept: $apiFormat" -H "Content-Type: $apiFormat" -H "X-Rundeck-Auth-Token: $rundeckToken" "$rundeckServer"/api/"$apiVersion"/projects -d "$(sed 's/ProjectXXXX/'$projectName'/g' template.project)"
	
	for y in $(eval echo "{1..$amountJobs}")
	do
		echo
		mod=$((y%60))	
		y=$(printf %04d $y)
		
		echo number $y
		echo mod $mod
		
		curl "$curlOpt" -X "POST" -H "Accept: $apiFormat" -H "Content-Type: $jobFormat" -H "X-Rundeck-Auth-Token: $rundeckToken" "$rundeckServer"/api/"$apiVersion"/project/jgarces-Project$n/jobs/import -d "$(sed 's/XXXX/'$y'/g' JobXXXX.yaml|sed 's/YYYY/'$mod'/g')"
	done
done
