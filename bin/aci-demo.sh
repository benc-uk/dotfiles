#!/bin/bash
image=bencuk/nodejs-demoapp
port=3000
grp=Temp.Containers
cname=demo-$RANDOM

echo "### Creating resource group..."
az group create -n $grp -l westeurope -o table

echo "" && echo "### Creating container '$cname'..."
az container create -n $cname -g $grp --image $image --port $port --ip-address public --query "{name:name, state:provisioningState, ip:ipAddress.ip, port:ipAddress.ports[0].port, os:osType}" -o table

echo "" && echo "### Waiting for container to deploy..."

state="NA"
while true
do
   state=`az container show -g $grp -n $cname -o tsv --query "provisioningState"`
   if [ "$state" == "Succeeded" ]; then
      echo "### Container is up!"
      url=`az container show -g $grp -n $cname --query "join('', ['http://',ipAddress.ip,':',to_string(ipAddress.ports[0].port)])" -o tsv`
      echo "### Connect to container using: $url"
      break
   fi
   echo "### Container is '$state', checking again in 5 seconds..."
   sleep 5
done