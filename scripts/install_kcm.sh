#!/bin/bash
set -euo pipefail

helm upgrade --install kcm \
  oci://registry.mirantis.com/k0rdent-enterprise/charts/k0rdent-enterprise \
  --version 1.1.0 \
  -n kcm-system \
  --create-namespace \
  -f helm/kcm.yaml

kubectl apply -f manifests/ingress-ui.yaml
kubectl apply -f manifests/k0rdent-catalog.yaml
