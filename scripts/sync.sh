#!/bin/bash
set -euo pipefail
# export REMOTE=108.130.16.138
# ./scripts/sync.sh -vurn

rsync --exclude '.git' -e ssh ./* ubuntu@$REMOTE:/home/ubuntu "$@"
