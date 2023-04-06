#!/usr/bin/env bash

source config

for n in $(eval echo "{1..$amountProjects}")
do
	n=$(printf %04d $n)
	count=0
	projectName="$projectPrefix-Project$n"

	echo $projectName

	curl "$curlOpt" -X "DELETE" -H "Accept: $rundeckApiFormat" -H "Content-Type: $rundeckApiFormat" -H "X-Rundeck-Auth-Token: $rundeckApiToken" "$rundeckServer"/api/"$rundeckApiVersion"/project/"$projectName"
done
