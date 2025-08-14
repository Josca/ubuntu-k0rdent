#!/bin/bash
set -euo pipefail

PASSWD="$(python3 scripts/askpass.py)" || exit 1
kubectl -n kcm-system set env deploy/kcm-k0rdent-ui BASIC_AUTH_PASSWORD="$PASSWD"
kubectl -n kcm-system rollout status deploy/kcm-k0rdent-ui
