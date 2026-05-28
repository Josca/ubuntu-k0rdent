#!/bin/bash
set -euo pipefail

helm upgrade --install keycloak-pg \
  oci://ghcr.io/k0rdent/catalog/charts/postgresql \
  --version 18.3.0 \
  -n keycloak \
  --create-namespace \
  -f helm/keycloak-2-pg.yaml
