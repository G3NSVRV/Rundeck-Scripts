#!/bin/bash
##############################
# Date for Test Only
# opts="-u -d 2019-08-01"
###############################
weekDay=$(date $opts +%a)
monthDay=$(date $opts +%d)
rundeckServer="localhost"
rundeckPort="4440"
rundeckApitoken="i7o0DgWdcPVsY8GkB19XF5szTTxh2mhD"
rundeckApiversion="17"
rundeckApiformat="xml"
rundeckProtocol="http"
rundeckJobid="5569276c-b6c0-4c7f-a9f0-aaad31cd1f03"
tmpFile="$HOME/cron.tmp"
curl -s -X "GET" -H "Accept: application/$rundeckApiformat" -H "Content-Type: application/$rundeckApiformat" -H "X-Rundeck-Auth-Token: $rundeckApitoken" "$rundeckProtocol"://"$rundeckServer":"$rundeckPort"/api/"$rundeckApiversion"/job/"$rundeckJobid" > "$tmpFile"
if [ "$weekDay" = "Sun" ] && [ "$monthDay" -eq "01" ]
then
        echo "Execute Day 8 of Month (0 0 0 8 * ? *)"
        sed -i 's/<weekday day=.*.$/<dayofmonth \/>/g' "$tmpFile"
        sed -i 's/<month.*/<month day='"'"'8'"'"' month='"'"'*'"'"' \/>/g' "$tmpFile"
else
    if [ "$monthDay" -lt "08" ]
    then
        echo "Execute First Sunday of Month (0 0 0 ? * 1#1 *)"
        sed -i 's/<dayofmonth.*.$/<weekday day='"'"'1#1'"'"' \/>/g' "$tmpFile"
        sed -i 's/<month.*/<month month='"'"'*'"'"' \/>/g' "$tmpFile"
    fi
fi
curl -s -X "POST" -H "Accept: application/$rundeckApiformat" -H "Content-Type: application/$rundeckApiformat" -H "X-Rundeck-Auth-Token: $rundeckApitoken" "$rundeckProtocol"://"$rundeckServer":"$rundeckPort"/api/"$rundeckApiversion"/project/"$RD_JOB_PROJECT"/jobs/import?dupeOption=update -d@"$tmpFile"
rm -f "$tmpFile"
echo "$(date $opts +%x)"
