#!/bin/bash

HELP=false

# Display usage
usage(){
echo "\
aks-nodes.sh - Start or stop all nodes in your AKS cluster
Parameters:
    -n, --name     Name of AKS managed cluster (required)
    -g, --group    Resource group containing AKS managed cluster (required)
    -a, --action   VM action [start, stop]
    [-h]           Show this help text
" | column -t -s ";"
}

# Param handling stuff
OPTS=`getopt -o n:g:a:h --long name:,group:,action:,help -n 'parse-options' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; usage; exit 1 ; fi
eval set -- "$OPTS"

# Param handling stuff
while true; do
  case "$1" in
    -n | --name ) AKS="$2"; shift; shift;;
    -g | --group ) GROUP="$2"; shift; shift;;
    -a | --action ) ACTION="$2"; shift; shift;;
    -h | --help ) HELP=true; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [ ${HELP} = true ] ; then 
  usage
  exit 0
fi

# Name and group are required params
if [ -z ${GROUP} ] || [ -z ${AKS} ] || [ -z ${ACTION} ] ; then
  usage
  exit 1
fi

# Action must be start or stop
if [[ ! ("$ACTION" == "stop" || "$ACTION" == "start") ]] ; then
  usage
  exit 1
fi

if [ ${ACTION} == "stop" ] ; then
  ACTION="deallocate"
fi

loc=`az resource show -g $GROUP -n $AKS --resource-type Microsoft.ContainerService/managedClusters --query "location" -o tsv`
if [ -z ${loc} ] ; then 
  echo "Error. Unable to find AKS cluster '$AKS' in group '$GROUP'"
  exit 0
fi

mcgroup="MC_${GROUP}_${AKS}_${loc}"
echo "Locating VMs in $mcgroup ..."

vmquery=`az vm list -g $mcgroup -o tsv --query "[].name"`
vmlist=$(echo $vmquery | tr " " "\n")

for vm in $vmlist
do
    az vm $ACTION -g $mcgroup -n $vm --no-wait
    echo "Running $ACTION on $vm ..."
done