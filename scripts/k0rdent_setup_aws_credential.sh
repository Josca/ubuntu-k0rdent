#!/bin/bash
set -euo pipefail

AWS_ACCESS_KEY_ID="$(python3 scripts/askpass.py AWS_ACCESS_KEY_ID --len 8)" || exit 1
AWS_SECRET_ACCESS_KEY="$(python3 scripts/askpass.py AWS_SECRET_ACCESS_KEY --len 8)" || exit 1

helm upgrade --install aws-credential oci://ghcr.io/k0rdent/catalog/charts/aws-credential \
    --version 0.0.1 \
    -n kcm-system

kubectl patch secret aws-credential-secret -n kcm-system -p='{"stringData":{"AccessKeyID":"'$AWS_ACCESS_KEY_ID'"}}'
kubectl patch secret aws-credential-secret -n kcm-system -p='{"stringData":{"SecretAccessKey":"'$AWS_SECRET_ACCESS_KEY'"}}'
