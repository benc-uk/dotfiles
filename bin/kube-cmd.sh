#!/bin/bash

image=${1:-"alpine/curl"}
cmd=${2:-"ps -ef"}

echo "🚀 Running command:"
echo "   kubectl run cmdrunner -it --rm --image=$image --restart=Never -- $cmd"
echo

kubectl run cmdrunner -it --rm --image="$image" --privileged --restart=Never -- $cmd
