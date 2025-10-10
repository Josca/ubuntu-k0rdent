#!/bin/bash

# Install k0s

set -euo pipefail

sudo k0s install controller --config k0s.yml --enable-worker --no-taints --enable-dynamic-config
sudo k0s start
