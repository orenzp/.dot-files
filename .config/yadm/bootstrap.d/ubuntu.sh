#!/bin/bash
# Function for echo format
function message () {
  echo -e "\e[1;32m
  ##################
  ##
  ##  $1
  ##
  ##################\e[0m
  "
}

message "Adding PPA repositorys"
sleep 5
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" 
sudo apt-add-repository ppa:fish-shell/release-3
sudo add-apt-repository ppa:git-core/ppa # stable PPA for latest stable Git version
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
sudo echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

message "Install Ubuntu packages"
sleep 5
sudo apt-get update && apt upgrade && export DEBIAN_FRONTEND=noninteractive 
sudo apt-get -y install --no-install-recommends bash-completion vim \
    software-properties-common dirmngr apt-transport-https lsb-release \
    iputils-ping ca-certificates etckeeper tlp tlp-rdw gpg smartmontools \
    ansible ansible-lint ansible-doc terraform fish 

read -p "Do you want to install Azure CLI?? (y/n)?" choice
case "$choice" in 
  y|Y ) curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash ;;
  n|N ) message "Aboring Azure CLI installation";;
  * ) message "invalid answer";;
esac

message "Setup Kubectl, HELM and add-ons"
sleep 5
if ! command -v helm &> /dev/null
then
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
else
    message "HELM Found $(helm version --short)"
fi

curl -L https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64 \
    --output stern && chmod +x stern && sudo mv stern /usr/local/bin/stern

curl -s "https://raw.githubusercontent.com/\
kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash \
    && sudo kustomize /usr/local/bin

message "Runnin small commands" "\e[1;32m$1\e[0m
terraform -install-autocomplete

read -p "\e[1;32mDo you want to decrypt YADM Files? (y/n)?\e[0m choice
case "$choice" in 
  y|Y ) yadm decrypt ;;
  n|N ) message "Aborting YADM Decrypt";;
  * ) message "invalid answer";;
esac
