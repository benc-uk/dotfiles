#!/bin/bash

image=${1:-busybox}
cmd=${2:-ls}

echo "kubectl run test -it --rm --image=$image --restart=Never -- $cmd"
kubectl run test -it --rm --image=$image --privileged --restart=Never -- $cmd
