#!/bin/bash

# Install k0s

set -euo pipefail

k0s config create > k0s.yml
