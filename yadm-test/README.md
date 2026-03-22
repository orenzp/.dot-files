# YADM Bootstrap Test (Ubuntu)

This directory contains a `Dockerfile` to test the `yadm` bootstrap process in a clean Ubuntu 22.04 environment.

## 1. Build the image
From the root of your repository, run:
```bash
docker build -t yadm-ubuntu-test yadm-test/
```

## 2. Run the test
To test your bootstrap script from a fresh environment, you'll need to pass your SSH keys so `yadm` can clone your repository.

```bash
docker run -it --rm \
    -v ~/.ssh/id_rsa:/home/tester/.ssh/id_rsa:ro \
    -v ~/.ssh/id_rsa.pub:/home/tester/.ssh/id_rsa.pub:ro \
    yadm-ubuntu-test
```

## 3. Inside the container
Once inside, clone your repository and initiate the bootstrap. The process is fully automated and non-interactive.

```bash
# Clone and run bootstrap non-interactively
GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" YADM_QUIET=true YADM_PASSPHRASE="your_password" yadm clone --bootstrap -p "your_password" git@github.com:orenzp/.dot-files.git
```

### Notes
- Your bootstrap script uses `sudo`, which is handled in the `Dockerfile` with `NOPASSWD`.
- The bootstrap script handles timezone (Asia/Jerusalem) and package installation non-interactively.
- `YADM_PASSPHRASE` is used to skip the interactive password prompt during `yadm decrypt`.
- `YADM_QUIET=true` can be used to bypass remaining confirmation prompts (e.g. Azure CLI).
