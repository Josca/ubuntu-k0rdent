#!/bin/bash
set -euo pipefail

helm upgrade --install ingress-nginx \
  oci://ghcr.io/k0rdent/catalog/charts/ingress-nginx \
  --version 4.13.0 \
  -n ingress-nginx \
  --create-namespace \
  -f helm/ingress-nginx.yaml
