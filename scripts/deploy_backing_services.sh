#! /bin/bash
set -euo pipefail

source $(dirname $0)/../.workspace.env

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# NOTE: metrics-server is already installed on the cluster by default
# kube state metrics
helm upgrade kube-state-metrics bitnami/kube-state-metrics \
  --install \
  --version 2.0.1 \
  --create-namespace \
  --namespace kube-system \
  --values "https://raw.githubusercontent.com/digitalocean/marketplace-kubernetes/master/stacks/kube-state-metrics/values.yml" \
  --wait
