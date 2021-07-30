# Get Remote State Storage Account details
tfstateRg=$TF_STATE_GROUP_NAME
tfstateAccount=$(az storage account list --resource-group "${tfstateRg}" | jq .[0])
tfstateAccountName=$(echo "$tfstateAccount" | jq .name -r)
tfstateAccountKey=$(az storage account keys list --resource-group "${tfstateRg}" --account-name "${tfstateAccountName}" | jq .[0].value -r)
tfstateContainer=$TF_STATE_CONTAINER_NAME
tfstateKeyName='key=aks-cluster.tfstate'
