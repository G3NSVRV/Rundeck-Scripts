#!/usr/bin/env bash

source config

for n in $(eval echo "{1..$amountProjects}")
do
	n=$(printf %04d $n)
	count=0
	projectName="$projectPrefix-Project$n"

	echo $projectName

	curl "$curlOpt" -X "DELETE" -H "Accept: $apiFormat" -H "Content-Type: $apiFormat" -H "X-Rundeck-Auth-Token: $rundeckToken" "$rundeckServer"/api/"$apiVersion"/project/"$projectName"
done
