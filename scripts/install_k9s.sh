#!/bin/bash

# Install k9s to Ubuntu 24.04 LTS

wget https://github.com/derailed/k9s/releases/latest/download/k9s_linux_amd64.deb && sudo apt install ./k9s_linux_amd64.deb && rm k9s_linux_amd64.deb

echo "export TERM=xterm" >> ~/.bashrc
