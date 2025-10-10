#!/bin/bash

# Install k0s

set -euo pipefail

sudo k0s kubectl config view --minify --raw > k0s_kubeconfig
