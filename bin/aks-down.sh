#!/bin/bash
echo "### Stopping all AKS nodes in cluster: bcdemo"
az vmss deallocate -g MC_Demo.AKS_bcdemo_northeurope -n aks-nodepool1-83851751-vmss --no-wait --verbose

