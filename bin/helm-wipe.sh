#!/bin/sh
helm ls -n $1 --short | xargs -L1 helm delete -n $1

