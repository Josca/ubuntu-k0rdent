#!/bin/bash
set -euo pipefail

helm upgrade --install traefik \
  oci://ghcr.io/k0rdent/catalog/charts/traefik \
  --version 39.0.8 \
  -n traefik \
  --create-namespace \
  -f helm/traefik.yaml
