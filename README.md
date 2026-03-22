# Dot-File Managment Repository

> STILL IN DRAFT

This repository holds all my .dot-files which are used to configure my workspace enviroment in either Linux, macOS or WSL2.
The repositry is managed using YADM a command line tool, YADM is basicly a smart tool that uses Git bare git repository to manage and version the Dotfiles in the home directory.

YADM is able to save secrets in Git by enabling encrypt decrypt of certain files before push and after clone

My prefer SHELL is fish Shell for all my workspaces.

## Quick Start: Initializing YADM

1. **Install yadm:** Follow the [official installation guide](https://yadm.io/docs/install#).
2. **Configure Identity:**
   ```sh
   git config --global user.name "Oren Zipori"
   git config --global user.email "orenzp@hotmail.com"
   ```
3. **Initiate & Bootstrap:**
   ```sh
   yadm clone --bootstrap https://github.com/orenzp/.dot-files.git
   ```
   *Post-clone, the `.config/yadm/bootstrap` script automatically installs Homebrew (macOS) or Fish (Linux), runs `brew bundle`, and updates the remote URL to SSH.*

4. **Non-Interactive Bootstrap (Automation):**
   The bootstrap process is designed to be non-interactive. You can provide your decryption passphrase and skip confirmation prompts via environment variables:
   ```sh
   YADM_QUIET=true YADM_PASSPHRASE="your_password" yadm clone --bootstrap -p "your_password" https://github.com/orenzp/.dot-files.git
   ```

5. **Manage Secrets:**
   - **Encrypt:** `yadm encrypt` (uses `openssl` via `.config/yadm/config`)
   - **Decrypt:** `yadm decrypt` (processes files matching `.config/yadm/encrypt`)
   - **Note:** `GPG_TTY` is auto-exported in `config.fish` for interactive prompts.

## Referance URL's:

- [YADM - Yet Another Dotfile Manager](https://yadm.io/)
- [FISH Shell](https://fishshell.com/)
