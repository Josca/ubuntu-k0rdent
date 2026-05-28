#!/bin/bash
set -euo pipefail

helm upgrade --install keycloak-1-secrets \
  oci://ghcr.io/k0rdent/catalog/charts/raw \
  --version 2.0.2 \
  -n keycloak \
  --create-namespace \
  -f helm/keycloak-1-secrets.yaml
