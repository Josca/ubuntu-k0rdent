#!/bin/bash
set -euo pipefail

# remove old commands
sudo rm -rf /usr/local/bin/k0rdent-*
rm -rf k0rdent-aws-setup
git clone https://github.com/Josca/k0rdent-aws-setup.git
mv k0rdent-aws-setup/scripts/setup-k0rdent-user.py "$(pwd)/scripts/setup-k0rdent-user.py"

sudo ln -s "$(pwd)/scripts/k0rdent_update_password.sh" /usr/local/bin/k0rdent-update-password
sudo ln -s "$(pwd)/k0rdent-aws-setup/setup.sh" /usr/local/bin/k0rdent-setup-aws-credential
sudo ln -s "$(pwd)/scripts/k0rdent_setup_azure_credential.sh" /usr/local/bin/k0rdent-setup-azure-credential
sudo ln -s "$(pwd)/scripts/k0rdent_setup_gcp_credential.sh" /usr/local/bin/k0rdent-setup-gcp-credential
sudo ln -s "$(pwd)/scripts/k0rdent_export_kubeconfig.sh" /usr/local/bin/k0rdent-export-kubeconfig
sudo ln -s "$(pwd)/scripts/k0rdent_show_ingress.sh" /usr/local/bin/k0rdent-show-ingress
sudo cp "$(pwd)/scripts/motd" /etc/motd
