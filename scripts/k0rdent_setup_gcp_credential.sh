#!/bin/bash
set -eo pipefail

# Usage:
# Set GCP credential environment variable before:
# export GCP_B64ENCODED_CREDENTIALS="..."

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

assert_env_var GCP_B64ENCODED_CREDENTIALS
assert_staus_ok

helm upgrade --install gcp-credential oci://ghcr.io/k0rdent/catalog/charts/gcp-credential \
    --version 0.0.1 \
    -n kcm-system

kubectl patch secret gcp-cloud-sa -n kcm-system -p='{"data":{"credentials":"'$GCP_B64ENCODED_CREDENTIALS'"}}'
