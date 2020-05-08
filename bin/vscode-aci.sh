# Change these five parameters as needed
SUFFIX=bc
ACI_PERS_RESOURCE_GROUP=Demo.ACI
ACI_PERS_STORAGE_ACCOUNT_NAME=cloudcode$SUFFIX
ACI_PERS_LOCATION=westeurope
ACI_PERS_SHARE_NAME=acishare

# Create the res group
az group create -n $ACI_PERS_RESOURCE_GROUP -l $ACI_PERS_LOCATION --output table

# Create the storage account with the parameters
az storage account create \
 --resource-group $ACI_PERS_RESOURCE_GROUP \
 --name $ACI_PERS_STORAGE_ACCOUNT_NAME \
 --location $ACI_PERS_LOCATION \
 --sku Standard_LRS

# Create the file share
az storage share create --name $ACI_PERS_SHARE_NAME --account-name $ACI_PERS_STORAGE_ACCOUNT_NAME
STORAGE_KEY=$(az storage account keys list --resource-group $ACI_PERS_RESOURCE_GROUP --account-name $ACI_PERS_STORAGE_ACCOUNT_NAME --query "[0].value" --output tsv)

# Deploy VS Code!
az container create \
 --resource-group $ACI_PERS_RESOURCE_GROUP \
 --name cloudcode \
 --image codercom/code-server \
 --command-line "code-server --allow-http --password=$PASSWORD_STD --port=80" \
 --cpu 1 \
 --memory 1.5 \
 --dns-name-label cloud-code-$SUFFIX \
 --ports 80 \
 --azure-file-volume-account-name $ACI_PERS_STORAGE_ACCOUNT_NAME \
 --azure-file-volume-account-key $STORAGE_KEY \
 --azure-file-volume-share-name $ACI_PERS_SHARE_NAME \
 --azure-file-volume-mount-path /root/project

IPADDRESS=$(az container show -g $ACI_PERS_RESOURCE_GROUP -n cloudcode --query "ipAddress.fqdn" -o tsv)

#az container logs -g $ACI_PERS_RESOURCE_GROUP -n cloudcode
echo "### Connect to VS Code in the cloud here! http://$HOST/"
