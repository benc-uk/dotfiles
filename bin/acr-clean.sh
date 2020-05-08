#!/bin/bash
#
# Removes all matching tags from an ACR repo
# params: {acr-name} {image-repository} {tag}
#

az acr repository show-tags -n $1 --repository $2 -o tsv | while read img ; do
  if [[ $img = *"$3"* ]]; then
    echo "Deleting image $2:$img ..."
    az acr repository delete -n $1 --image $2:$img --yes &
  fi
done

