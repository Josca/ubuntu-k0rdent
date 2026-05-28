#!/bin/bash
set -euo pipefail

helm upgrade --install postgresql \
  oci://ghcr.io/k0rdent/catalog/charts/postgresql \
  --version 16.7.21 \
  -n postgresql \
  --create-namespace \
  -f helm/postgresql.yaml
