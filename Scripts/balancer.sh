#!/bin/sh
#############################################
# echo "Please insert Rundeck Server node 1:"; read cluster_01
# echo "Please insert Rundeck Server node 2:"; read cluster_02
#############################################
# to run unatended mode, please comment the code above and uncomment the code below, and replace with your props
#############################################
cluster_01="node01.rundeck.local"
cluster_02="node02.rundeck.local"
#############################################

server_ip=$(ping $cluster_01 -c 1 | head -n 1 | awk '{print $3}' | tr -d '()')
firewall-cmd --reload
firewall-cmd --add-forward-port=port=80:proto=tcp:toport=4440:toaddr="$server_ip"

if [ "$(curl -s -w %{http_code} $cluster_01:4440)" == "302" ]
then
echo "Server 1 OK";
else
echo "Server 1 Down";
server_ip=$(ping $cluster_02 -c 1 | head -n 1 | awk '{print $3}' | tr -d '()')
firewall-cmd --reload
firewall-cmd --add-forward-port=port=80:proto=tcp:toport=4440:toaddr="$server_ip"
ssh root@$cluster_01 -o StrictHostKeyChecking=no 'service rundeckd start'
fi

if [ "$(curl -s -w %{http_code} $cluster_02:4440)" == "302" ]
then
echo "Server 2 OK";
else
echo "Server 2 Down";
ssh root@$cluster_02 -o StrictHostKeyChecking=no 'service rundeckd start'
fi
