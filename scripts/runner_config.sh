#!/bin/bash

# This script is intended to be run on an Ubuntu 20.04 server to set
# up the necessary environment for running the DarkMesaSecurity project.

# Runner installation

# SSH configuration

# Sudoers configuration
# Hopefully not needed. 

# Install required packages
# Official script from HashiCorp to install Terraform on Ubuntu
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform