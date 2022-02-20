#!/bin/bash
source $(dirname $0)/../.workspace.env

# Create Resource Group for Terraform Remote State
groupName=TF_STATE_RG_NAME
groupLocation=TF_STATE_RG_LOCATION
group=$(az group create --name ${groupName} --location "${groupLocation}" --verbose)

# Create Storage Account for Terraform Remote State
accountName=TF_STATE_ACCOUNT_NAME
storage=$(az storage account create \
    --name ${accountName} \
    --resource-group $(echo "$group" | jq .name -r) \
    --location $(echo "$group" | jq .location -r) \
    --sku Standard_LRS \
    )

# Create container for Terraform Remote State
containerName=$TF_STATE_CONTAINER_NAME
az storage container create \
    --name ${containerName} \
    --account-name $(echo "$storage" | jq .name -r) \
    --account-key $(az storage account keys list --resource-group $(echo "$group" | jq .name -r) --account-name $(echo "$storage" | jq .name -r) | jq .[0].value -r)
