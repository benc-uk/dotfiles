#!/bin/bash

##### deploy.sh ################################################################
# Purpose: General purpose ARM template deployment script for Azure CLI
# Author:  Ben Coleman
# Date:    23-06-2017, Updated 09-07-2019
# Version: 2.0.1
################################################################################

# Defaults
DEFAULT_LOC='West Europe'
HELP=false
VALIDATE=false
DATE=`date +%Y%m%d_%H.%M.%S`
DEPLOY_NAME="az-deploy_$DATE"
SUB=""
GRP_PREFIX="Temp.Deployment."

# Display usage
usage(){
echo -e "\
\e[34m════════════════════════════════════════════════════════════
az-deploy.sh - Deploy Azure Resource Manager (ARM) templates
════════════════════════════════════════════════════════════
\e[39mParameters:
    -t, --template       \e[33mInput template file (required)\e[39m
    [-g, --group]        \e[33mResource group to deploy to, will be created\e[39m
    [-l, --location]     \e[33mRegion or location for the resource group, default: westeurope\e[39m
    [-p, --parameters]   \e[33mParameter file, if ommited then <inputfile>.parameters.json is used\e[39m
    [-s, --subscription] \e[33mAzure subscription (name or ID) to use\e[39m
    [-h]                 \e[33mShow this help text\e[39m
" | column -t -s ";"
}

# Param handling stuff
OPTS=`getopt -o t:g:p:l:s:h --long template:,group:,location:,subscription:,parameters:,help -n 'parse-options' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; usage; exit 1 ; fi
eval set -- "$OPTS"

# Param handling stuff
while true; do
  case "$1" in
    -t | --template ) FILE="$2"; shift; shift;;
    -g | --group ) GROUP="$2"; shift; shift;;
    -p | --parameters ) PARAMS="$2"; shift; shift;;
    -l | --location ) LOC="$2"; shift; shift;;
    -s | --subscription ) SUB="$2"; shift; shift;;
    -h | --help ) HELP=true; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [ ${HELP} = true ]; then
  usage
  exit 0
fi

# We need the template file param at a minimum
if [ -z ${FILE} ]; then
  usage
  exit 1
fi

echo -e "\n\e[34m╔══════════════════════════════════╗"
echo -e "║\e[33m      ARM Template Deployer\e[34m       ║"
echo -e "╚══════════════════════════════════╝"
echo -e "\e[35mBen Coleman, 2019   \e[39mv2.0.1  🚀 🚀 🚀\n"

echo -e "\e[34m»»» 🍳  \e[32mRunning pre-req checks\e[0m..."
az > /dev/null 2>&1
if [ $? -ne 0  ]; then
  echo -e "\e[31m»»» ⚠️  Azure CLI is not installed! 😥  Please go to http://aka.ms/cli to set it up"
  exit
fi

# If not provided, infer parameter file name from the template file name 
if [ -z ${PARAMS} ]; then
  PARAMS="${FILE::-5}.parameters.json"
  echo -e "\e[34m»»» 🚩  \e[32mParameter file not provided, \e[33m'$PARAMS'\e[32m is infered"
fi

# Check file existence
if ! [[ -e ${FILE} ]]; then
  echo -e "\e[31m»»» ⚠️  Template file \e[33m'$FILE'\e[31m not found, exiting now!"
  exit
fi
if ! [[ -e ${PARAMS} ]]; then
  echo -e "\e[31m»»» ⚠️  Parameters file \e[33m'$PARAMS'\e[31m not found, exiting now!"
  exit
fi

# Append subscription parameter to commands if provided
APPEND_SUB=""
if [ -z "${SUB}" ]; then
  echo -e "\e[34m»»» 🔑  \e[32mUsing default subscription \e[33m'$(az account show --query name -o tsv)'\e[39m"
else
  echo -e "\e[34m»»» 🔑  \e[32mUsing specified subscription \e[33m'$SUB'\e[39m"
  APPEND_SUB="--subscription '${SUB}'"
fi

# Set default location
if [ -z ${LOC} ]; then
  LOC=$DEFAULT_LOC
  echo -e "\e[34m»»» 🚩  \e[32mLocation not provided, default \e[33m'$DEFAULT_LOC'\e[32m will be used"
fi

# Make up a res group name if it's not supplied, appended with a random number
if [ -z ${GROUP} ]; then
  GROUP=$GRP_PREFIX$(shuf -i 1-100000 -n 1)
  echo -e "\e[34m»»» 🚩  \e[32mGroup name not provided, \e[33m'$GROUP'\e[32m will be used"
fi

# Create resource group
echo -e "\e[34m»»» 🔨  \e[32mCreating resource group \e[33m'$GROUP'\e[39m..."
cmd="az group create -n $GROUP -l '$LOC' $APPEND_SUB -o none"
# echo $cmd
eval $cmd

# It all leads up to this one command! Start the deployment
echo -e "\e[34m»»» 🔨  \e[32mStarting deployment \e[33m'$DEPLOY_NAME'\e[32m Please wait\e[39m...\e[36m"
cmd="az group deployment create -g $GROUP $APPEND_SUB --template-file '$FILE' --parameters '@${PARAMS}' --verbose --name '$DEPLOY_NAME' -o yaml --query '[properties.{outputs: outputs},properties.{status: provisioningState}]'"
# echo $cmd
eval $cmd
