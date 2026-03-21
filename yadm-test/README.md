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
Once inside, clone your repository and initiate the bootstrap:

```bash
# Clone and run bootstrap (provide your repo URL)
yadm clone --bootstrap git@github.com:orenzp/.dot-files.git
```

### Notes
- Your bootstrap script currently uses `sudo`, which is handled in the `Dockerfile`.
- Some packages might fail in a containerized environment (like hardware-specific tools or systemd-dependent services).
- You may need to manually bypass or answer interactive prompts during the bootstrap process.
