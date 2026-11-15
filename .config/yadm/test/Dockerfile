FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install core dependencies for yadm and your bootstrap script
RUN apt-get update && apt-get install -y \
    sudo \
    git \
    curl \
    yadm \
    ca-certificates \
    lsb-release \
    software-properties-common \
    gnupg2 \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Create a test user with sudo privileges (no password required)
RUN useradd -m -s /bin/bash tester && \
    echo "tester ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set the user
USER tester
WORKDIR /home/tester

# Prepare SSH directory (to be used with bind mount for your keys)
RUN mkdir -p /home/tester/.ssh && chmod 700 /home/tester/.ssh

# Entry point: start a bash shell
CMD ["/bin/bash"]
