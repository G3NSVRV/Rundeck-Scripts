#!/usr/bin/env bash

source config

for n in $(eval echo "{1..$amountProjects}")
do
	n=$(printf %04d $n)
	count=0
	projectName="$projectPrefix-Project$n"
	
	echo $projectName

	curl "$curlOpt" -X "POST" -H "Accept: $rundeckApiFormat" -H "Content-Type: $rundeckApiFormat" -H "X-Rundeck-Auth-Token: $rundeckApiToken" "$rundeckServer"/api/"$rundeckApiVersion"/projects -d "$(sed 's/ProjectXXXX/'$projectName'/g' template.project)"
	
	for y in $(eval echo "{1..$amountJobs}")
	do
		echo
		mod=$((y%60))	
		y=$(printf %04d $y)
		
		echo number $y
		echo mod $mod
		
		curl "$curlOpt" -X "POST" -H "Accept: $rundeckApiFormat" -H "Content-Type: $rundeckJobFormat" -H "X-Rundeck-Auth-Token: $rundeckApiToken" "$rundeckServer"/api/"$rundeckApiVersion"/project/jgarces-Project$n/jobs/import -d "$(sed 's/XXXX/'$y'/g' JobXXXX.yaml|sed 's/YYYY/'$mod'/g')"
	done
done
