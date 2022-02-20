#!/bin/bash
# Helper script to configure the storage account and state backend for Terraform

# Source env variables
source $(dirname $0)/../.workspace.env

# Exit if something fails
set -euo pipefail

# Create resource group
az group create --name "$TF_STATE_RG_NAME" --location "$TF_STATE_RG_LOCATION"

# Create storage account
az storage account create --resource-group "$TF_STATE_RG_NAME" --name "$TF_STATE_ACCOUNT_NAME" --sku Standard_LRS --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group "$TF_STATE_RG_NAME" --account-name "$TF_STATE_ACCOUNT_NAME" --query '[0].value' -o tsv)

# Create blob container
az storage container create --name "$TF_STATE_CONTAINER_NAME" --account-name "$TF_STATE_ACCOUNT_NAME" --account-key "$ACCOUNT_KEY"

# Print necessary outputs
echo "storage_account_name: $TF_STATE_ACCOUNT_NAME"
echo "container_name: $TF_STATE_CONTAINER_NAME"
echo "access_key: $ACCOUNT_KEY"
