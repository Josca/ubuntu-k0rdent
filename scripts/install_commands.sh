#!/bin/bash
set -euo pipefail

sudo ln -s "$(pwd)/scripts/k0rdent_update_password.sh" /usr/local/bin/k0rdent-update-password
sudo ln -s "$(pwd)/scripts/k0rdent_setup_aws_credential.sh" /usr/local/bin/k0rdent-setup-aws-credential
sudo ln -s "$(pwd)/scripts/k0rdent_setup_azure_credential.sh" /usr/local/bin/k0rdent-setup-azure-credential
