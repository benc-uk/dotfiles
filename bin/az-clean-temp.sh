#!/bin/bash

groups=`az group list --query "[].name" -o tsv`
delGroups=()
for group in $groups; do
  if [[ "${group,,}" =~ .*"temp".* ]]; then
    delGroups+="$group,"
  fi
done

IFS=$','
for group in $delGroups; do
  echo -e "\e[31m»»» 💥 Going to delete resource group: \e[0m$group"
  read -n 1 -s -r -p $'Press any key to continue, or ctrl-c to exit\n'
  echo -e "\e[33m»»» 👋 az group delete -g $group --no-wait --yes"
  az group delete -g $group --no-wait --yes
done

