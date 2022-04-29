#!/bin/bash

echo -e "\e[34m»»»\e[32m 🧹 Azure resource group wiper\e[0m"

if [ -z "$1" ]; then
  echo -e "\e[34m»»»\e[0m Usage: $0 \e[33m<resource group substring>"
  exit 1
fi

groups=$(az group list --query "[].name" -o tsv)
wildcard=$1
delGroups=()
for group in $groups; do
  if [[ "${group,,}" =~ .*"$wildcard".* ]]; then
    delGroups+="$group,"
  fi
done

if (( "${#delGroups[@]}" <= 0 )); then
  echo -e "\e[34m»»»\e[31m 😩 No resource groups found matching '$wildcard'\e[0m"
  exit 1
fi

IFS=$','
for group in $delGroups; do
  echo -e "\e[31m»»» 💥 Going to delete resource group: \e[0m$group"
  read -n 1 -s -r -p $'Press any key to continue, or ctrl-c to exit\n'
  echo -e "\e[33m»»» 👋 az group delete -g $group --no-wait --yes"
  az group delete -g "$group" --no-wait --yes
done

