#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: Missing required argument."
  echo "Usage: $0 <cluster-deployment-name>"
  kubectl get cld -A
  exit 1
fi

kubectl get secret $1-kubeconfig -n kcm-system -o=jsonpath={.data.value} | base64 -d
