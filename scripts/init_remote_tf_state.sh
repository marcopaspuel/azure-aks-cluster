#!/bin/bash
# Helper script to initialize Terraform from the remote state

# Source env variables
source $(dirname $0)/../.workspace.env

# Exit if something fails
set -euo pipefail

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group "$TF_STATE_RG_NAME" --account-name "$TF_STATE_ACCOUNT_NAME" --query '[0].value' -o tsv)

# Initialise Terraform
cd terraform
rm -R -f .terraform
terraform init \
    -backend-config="storage_account_name=$TF_STATE_ACCOUNT_NAME" \
    -backend-config="container_name=$TF_STATE_CONTAINER_NAME" \
    -backend-config="access_key=$ACCOUNT_KEY" \
    -backend-config="key=terraform.tfstate"
