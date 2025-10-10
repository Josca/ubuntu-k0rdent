#!/bin/bash

# Install k0s

set -euo pipefail

curl --proto '=https' --tlsv1.2 -sSf https://get.k0s.sh | sudo sh
