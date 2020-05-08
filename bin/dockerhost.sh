#!/bin/bash

# Docker env
echo "# Set these variables to connect to dockerhost"
echo export DOCKER_TLS_VERIFY="1"
echo export DOCKER_HOST="tcp://dockerhost.uksouth.cloudapp.azure.com:2376"
echo export DOCKER_CERT_PATH="/home/ben/.docker/machine/machines/dockerhost"
echo export DOCKER_MACHINE_NAME="dockerhost"

echo ""

echo "# Now ${1}-ing the Docker VM..."
az vm $1 -g Demo.Containers -n dockerhost --no-wait -o table
