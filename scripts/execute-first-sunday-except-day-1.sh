#!/bin/bash
opts="-u -d 2019-08-06"
weekDay=$(date $opts +%a)
monthDay=$(date $opts +%d)

if [ "$weekDay" = "Sun" ] && [ "$monthDay" -eq "01" ]
	then
	if [ "$monthDay" -eq "01" ]
		then
		echo "Execute Day 8 of Month (0 0 0 8 * ? *)"
	fi
else
	if [ "$monthDay" -lt "08" ]
		then
		echo "Execute First Sunday of Month (0 0 0 ? * 1#1 *)"
	fi
fi

echo $(date $opts +%x)
