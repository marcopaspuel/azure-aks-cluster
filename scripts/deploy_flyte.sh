#!/bin/bash
# Helper script to initialize Terraform from the remote state

# Source env variables
source $(dirname $0)/../.workspace.env

# Exit if something fails
set -euo pipefail

# Get helm Chart
helm repo add flyte https://flyteorg.github.io/flyte
helm repo update

# Deploy Flyte
helm upgrade flyte flyte/flyte \
    --install \
    --create-namespace \
    --namespace flyte \
    -f values.yaml

#helm install -n flyte -f values.yaml --create-namespace flyte flyte/flyte
