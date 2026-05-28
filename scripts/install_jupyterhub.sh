#!/bin/bash
set -euo pipefail

helm upgrade --install jupyterhub \
  oci://ghcr.io/k0rdent/catalog/charts/jupyterhub \
  --version 4.3.5 \
  -n jupyterhub \
  --create-namespace \
  -f helm/jupyterhub.yaml
