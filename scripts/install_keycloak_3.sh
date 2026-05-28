#!/bin/bash
set -euo pipefail

helm upgrade --install keycloak \
  oci://ghcr.io/k0rdent/catalog/charts/keycloakx \
  --version 7.2.0 \
  -n keycloak \
  --create-namespace \
  -f helm/keycloak-3.yaml
