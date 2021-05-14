# Home Directory Setup

bareGit enable to backup and version Linux home directory setup for .dotfiles.
This configuration is for Fish shell setup.


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

## bareGit backup and versioning.

```bash
alias bare='git --git-dir=$HOME/.git-bare/ --work-tree=$HOME'
echo ".git-bare" >> .gitignore
git clone --bare git@github.com:orenzp/git-bare.git $HOME/.git-bare
bare config --local status.showUntrackedFiles no
```

## Referance URL's:
*[The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles)*

*[What do you use to manage dotfiles?](https://news.ycombinator.com/item?id=11071754)*
