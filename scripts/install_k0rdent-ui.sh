#!/bin/bash

# Install k0rdent-ui - as a separated chart (got from k0rdent-enterprise dependency chart)

helm pull oci://registry.mirantis.com/k0rdent-enterprise/charts/k0rdent-enterprise --version 1.1.0 --untar

helm install kcm-k0rdent-ui k0rdent-enterprise/charts/k0rdent-ui -f helm/k0rdent-ui.yaml -n kcm-system

kubectl apply -f manifests/ingress-ui.yaml
