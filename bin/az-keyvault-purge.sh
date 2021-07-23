#!/bin/bash

echo "This will purge ALL soft deleted KeyVaults"
read -n 1 -s -r -p $'Press any key to continue, or ctrl-c to exit\n'

list=$(az keyvault list-deleted --query "[].name" -o tsv)

[[ $list == "" ]] && { echo "No deleted KeyVaults found"; exit 1; }

while IFS= read -r name; do
  echo "Purging KeyVault $name"
  az keyvault purge -n $name --no-wait
done <<< "$list"
