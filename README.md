# Dot File Managment Repository

This repository holds all my .dot-files which are used to configure my workspace enviroment in either Linux, macOS or WSL2.
The repositry is managed using YADM a command line tool, YADM is basicly a smart tool that uses Git bare git repository to manage and version the Dotfiles in the home directory.

YADM is able to save secrets in Git by enabling encrypt decrypt of certain files before push and after clone


# Setup Requriements

## Install FISH Shell
```bash
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish
```

## Install packages:
sudo apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends bash-completion vim \
    software-properties-common dirmngr apt-transport-https lsb-release \
    iputils-ping ca-certificates etckeeper 

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az aks install-cli
rr
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
curl -L https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64 --output stern && chmod +x stern && sudo mv stern /usr/local/bin/stern
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - \
    && sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && sudo apt-get update && sudo apt-get install terraform \
    && terraform -install-autocomplete

set -x; cd "$(mktemp -d)" && \
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" && \
    tar zxvf krew.tar.gz && \
    KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_$(uname -m | sed -e 's/x86_64/amd64/' -e 's/arm.*$/arm/')" && \
    "$KREW" install krew 


## Referance URL's:
- [YADM - Yet Another Dotfile Manager](https://yadm.io/)
- [FISH Shell](https://fishshell.com/)
