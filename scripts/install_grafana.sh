#!/bin/bash
set -euo pipefail

helm upgrade --install grafana \
  oci://ghcr.io/k0rdent/catalog/charts/kube-prometheus-stack \
  --version 84.2.1 \
  -n grafana \
  --create-namespace \
  -f helm/grafana.yaml

# kubectl get secret grafana -n grafana -o jsonpath="{.data.admin-password}" | base64 -d; echo
