#!/bin/bash
set -eu

echo "--- Starting YADM Test ---"

# Ensure non-interactive mode for all tools
export DEBIAN_FRONTEND=noninteractive

# Disable SSH strict host key checking to prevent host key confirmation prompts
export GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no"

# 1. Clone the repository (using local path)
# We use --bootstrap to trigger the bootstrap script immediately
# We set YADM_QUIET=true to avoid interactive prompts in the bootstrap logic
export YADM_QUIET=true
yadm clone --bootstrap /repo

echo "--- Verifying Package Installation ---"

PACKAGES="bash-completion vim software-properties-common dirmngr apt-transport-https lsb-release iputils-ping ca-certificates etckeeper gpg smartmontools ansible ansible-lint terraform fish fortune ntpdate unzip"

MISSING_PACKAGES=()
for pkg in $PACKAGES; do
    if dpkg -s "$pkg" >/dev/null 2>&1; then
        echo "[OK] $pkg is installed"
    else
        echo "[FAIL] $pkg is NOT installed"
        MISSING_PACKAGES+=("$pkg")
    fi
done

# Specific check for timezone
TIMEZONE=$(cat /etc/timezone || echo "Not found")
echo "Current Timezone: $TIMEZONE"

if [ ${#MISSING_PACKAGES[@]} -eq 0 ]; then
    echo "--- ALL PACKAGES INSTALLED SUCCESSFULLY ---"
    exit 0
else
    echo "--- SOME PACKAGES ARE MISSING: ${MISSING_PACKAGES[*]} ---"
    exit 1
fi
