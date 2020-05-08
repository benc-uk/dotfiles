#!/bin/bash

echo "Warning! About to delete all your temp resource groups..."

while true; do
    read -p "Do you wish to continue (y/n)? " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) echo "OK, aborting, bye!"; exit;;
        * ) echo "Please answer y or n";;
    esac
done

groups=`az group list --query "[].name" -o tsv`

for group in $groups; do
   if [[ "${group,,}" == *"temp"* ]]; then
      echo "Deleting resource group '$group'..."
      az group delete --yes --no-wait --verbose -n $group
   fi
done
