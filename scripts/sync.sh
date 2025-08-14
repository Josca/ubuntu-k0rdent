#!/bin/bash
set -euo pipefail
# export EC2IP=108.130.16.138
# ./scripts/sync.sh -vurn

rsync --exclude '.git' -e ssh ./* ubuntu@$EC2IP:/home/ubuntu "$@"
