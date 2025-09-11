#!/bin/bash
set -eo pipefail

# Usage:
# Set Azure credential environment variables before:
# export AZURE_SP_APP_ID="..."
# export AZURE_SP_TENANT_ID="..."
# export AZURE_SUB_ID="..."
# export AZURE_SP_PASSWORD="..."

status="ok"
assert_staus_ok() {
  if [[ $status != "ok" ]]; then
    exit 1
  fi
}

assert_env_var() {
  local var_name="$1"
  if [ -z "${!var_name}" ]; then
    echo "Error: $var_name is unset or empty" >&2
    status="err"
  fi
}

assert_env_var AZURE_SP_APP_ID
assert_env_var AZURE_SP_TENANT_ID
assert_env_var AZURE_SUB_ID
assert_env_var AZURE_SP_PASSWORD
assert_staus_ok

helm upgrade --install azure-credential oci://ghcr.io/k0rdent/catalog/charts/azure-credential \
    --version 1.0.0 \
    -n kcm-system \
    --set "spAppID=${AZURE_SP_APP_ID}" \
    --set "spTenantID=${AZURE_SP_TENANT_ID}" \
    --set "subID=${AZURE_SUB_ID}"

kubectl patch secret azure-credential-secret -n kcm-system -p='{"stringData":{"clientSecret":"'$AZURE_SP_PASSWORD'"}}'
kubectl patch secret azure-credential-secret-aks -n kcm-system -p='{"stringData":{"AZURE_CLIENT_SECRET":"'$AZURE_SP_PASSWORD'"}}'
