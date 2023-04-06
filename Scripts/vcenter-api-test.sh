#!/bin/bash

#####

echo
echo "Please fill your vCenter credentials:"
echo "Hostname: "; read -r host
echo
echo "Username: "; read -r username
echo
echo "Password: "; read -r password
echo

#####

#host="https://192.168.235.207"
#username="administrator@vsphere.local"
#password='Pa$$w0rd'

######

sessionID=$(curl -s -k -X POST "$host"/rest/com/vmware/cis/session -u "$username:$password" | jq .value | tr -d '"')

echo "VMs List and State:"
curl -s -k -X GET -H "vmware-api-session-id: $sessionID" "$host"/rest/vcenter/vm | jq .value > vm-list.log

echo
echo "VMs Details:"
for vmID in $(curl -s -k -X GET -H "vmware-api-session-id: $sessionID" "$host"/rest/vcenter/vm | jq .value[].vm | tr -d '"')
do
  echo "\\\\$vmID"
  curl -s -k -X GET -H "vmware-api-session-id: $sessionID" "$host"/rest/vcenter/vm/"$vmID" | jq .value
done > vm-state.log

curl -s -k -X DELETE -H "vmware-api-session-id: $sessionID" "$host"/rest/com/vmware/cis/session
