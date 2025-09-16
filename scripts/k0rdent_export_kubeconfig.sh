#!/bin/bash
set -eo pipefail

if [ -z "$1" ]; then
  echo "Error: Missing required argument."
  echo "Usage: $0 <cluster-deployment-name>"
  kubectl get cld -A
  exit 1
fi

if ! kubectl get secret $1-kubeconfig -n kcm-system > /dev/null; then
  exit 1
fi
kubectl get secret $1-kubeconfig -n kcm-system -o=jsonpath={.data.value} | base64 -d > "$1-kubeconfig"

echo "Child cluster kubeconfig exported to '$1-kubeconfig'"
echo "Usage example:"
echo
echo "# Show child cluster pods:"
echo "KUBECONFIG=$1-kubeconfig kubectl get pod -A"
echo
echo "# Show child cluster ingress items (exposed addresses):"
echo "KUBECONFIG=$1-kubeconfig kubectl get ingress -A"
echo
echo "# Inspect child cluster using k9s UI"
echo "KUBECONFIG=$1-kubeconfig k9s"
