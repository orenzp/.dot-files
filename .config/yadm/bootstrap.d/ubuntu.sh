#!/bin/bash
echo "Adding PPA repositorys"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - \
    && sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" 
sudo apt-add-repository ppa:fish-shell/release-3
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "Install desired packages "
apt-get update && apt upgrade && export DEBIAN_FRONTEND=noninteractive 
apt-get -y install --no-install-recommends bash-completion vim \
    software-properties-common dirmngr apt-transport-https lsb-release \
    iputils-ping ca-certificates etckeeper tlp tlp-rdw gpg smartmontools \
    terraform fish kubectl

read -p "Do you want to install Azure CLI?? (y/n)?" choice
case "$choice" in 
  y|Y ) curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash ;;
  n|N ) echo "Aboring Azure CLI installation";;
  * ) echo "invalid answer";;
esac


echo "Setup Kubectl, HELM and add-ons"
if ! command -v helm &> /dev/null
then
    echo "Installing HELM"
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
else
    echo "HELM Found $(helm version --short)"
fi

curl -L https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64 \
    --output stern && chmod +x stern && sudo mv stern /usr/local/bin/stern

curl -s "https://raw.githubusercontent.com/\
kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash \
    && sudo kustomize /usr/local/bin

echo "Runnin small commands"
terraform -install-autocomplete

read -p "Do you want to decrypt YADM Files? (y/n)?" choice
case "$choice" in 
  y|Y ) yadm decrypt ;;
  n|N ) echo "Aborting YADM Decrypt";;
  * ) echo "invalid answer";;
esac
