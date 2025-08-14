#!/bin/bash
set -euo pipefail

AZURE_SP_APP_ID="$(python3 scripts/askpass.py AZURE_SP_APP_ID --len 8)" || exit 1
AZURE_SP_TENANT_ID="$(python3 scripts/askpass.py AZURE_SP_TENANT_ID --len 8)" || exit 1
AZURE_SUB_ID="$(python3 scripts/askpass.py AZURE_SUB_ID --len 8)" || exit 1
AZURE_SP_PASSWORD="$(python3 scripts/askpass.py AZURE_SP_PASSWORD --len 8)" || exit 1

helm upgrade --install azure-credential oci://ghcr.io/k0rdent/catalog/charts/azure-credential \
    --version 1.0.0 \
    -n kcm-system \
    --set "spAppID=${AZURE_SP_APP_ID}" \
    --set "spTenantID=${AZURE_SP_TENANT_ID}" \
    --set "subID=${AZURE_SUB_ID}"

kubectl patch secret azure-credential-secret -n kcm-system -p='{"stringData":{"clientSecret":"'$AZURE_SP_PASSWORD'"}}'
kubectl patch secret azure-credential-secret-aks -n kcm-system -p='{"stringData":{"AZURE_CLIENT_SECRET":"'$AZURE_SP_PASSWORD'"}}'
