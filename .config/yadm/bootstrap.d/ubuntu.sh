#!/bin/bash
echo "Running apt update & apt "
apt-get update && apt upgrade && export DEBIAN_FRONTEND=noninteractive 
apt-get -y install --no-install-recommends bash-completion vim \
    software-properties-common dirmngr apt-transport-https lsb-release \
    iputils-ping ca-certificates etckeeper tlp tlp-rdw gpg smartmontools

echo "Installing AZ Cli, Kubectl and HELM"
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az aks install-cli
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

echo "Installing Terraform with Auto complition"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - \
    && sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && sudo apt-get update && sudo apt-get install terraform \
    && terraform -install-autocomplete

echo "Setup Kuberentes add-ons"
curl -L https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64 \
    --output stern && chmod +x stern && sudo mv stern /usr/local/bin/stern

curl -s "https://raw.githubusercontent.com/\
kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bashmv \
    && sudo kustomize /usr/local/bin

## Install FISH Shell

sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish

echo "Running yadm decrypt"
yadm decrypt
