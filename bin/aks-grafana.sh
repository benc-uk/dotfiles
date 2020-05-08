#!/bin/bash
echo "### Creating tunnel to Grafana"
export GRAFANA_POD_NAME=$(kubectl get pods --namespace monitoring -l "app=grafana,release=grafana" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace monitoring port-forward $GRAFANA_POD_NAME 3000:3000 > /dev/null &
