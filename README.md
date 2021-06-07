# Dot File Managment Repository

This repository holds all my .dot-files which are used to configure my workspace enviroment in either Linux, macOS or WSL2.
The repositry is managed using YADM a command line tool, YADM is basicly a smart tool that uses Git bare git repository to manage and version the Dotfiles in the home directory.

YADM is able to save secrets in Git by enabling encrypt decrypt of certain files before push and after clone

My prefer SHELL is fish Shell for all my workspaces.

## Setup Requriements

**Install YADM Package Manager**

```shell
    curl -fLo /usr/local/bin/yadm \
    https://github.com/TheLocehiliosan/yadm/raw/master/yadm && \ 
    chmod a+x /usr/local/bin/yadm
```

**Clone the dot-file manager repo**

`yadm clone https://github.com/orenzp/.dot-files.git`

NOTE that after yadm clone YADM will execute a bootstap script in .config/yadm/bootstrap


### Referance URL's:
- [YADM - Yet Another Dotfile Manager](https://yadm.io/)
- [FISH Shell](https://fishshell.com/)
- 