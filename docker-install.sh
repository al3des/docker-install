#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Uninstall old versions of Docker if they exist
echo "Removing old Docker versions if any..."
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
    sudo apt-get remove -y $pkg || true
done

# Update the package index
echo "Updating package index..."
sudo apt-get update

# Install prerequisites
echo "Installing prerequisites..."
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Set up Docker's official GPG key
echo "Adding Docker's official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Detect if the system is Ubuntu or Debian
source /etc/os-release

if [[ "$ID" == "ubuntu" ]]; then
    REPO_URL="https://download.docker.com/linux/ubuntu"
    CODENAME="${UBUNTU_CODENAME:-$VERSION_CODENAME}"
elif [[ "$ID" == "debian" ]]; then
    REPO_URL="https://download.docker.com/linux/debian"
    CODENAME="${DEBIAN_CODENAME:-$VERSION_CODENAME}"
else
    echo "Unsupported OS"
    exit 1
fi

# Add the Docker repository
echo "Adding Docker repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] $REPO_URL $CODENAME stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index again
echo "Updating package index after adding Docker repository..."
sudo apt-get update

# Install Docker Engine and associated packages
echo "Installing Docker Engine and components..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify installation by running hello-world
echo "Verifying Docker installation..."
sudo docker run hello-world

# Manage Docker as a non-root user
echo "Configuring Docker to run as a non-root user..."
# Create the docker group if it doesn't exist
if ! getent group docker > /dev/null; then
    sudo groupadd docker
    echo "Docker group created."
fi

# Add the current user to the docker group
sudo usermod -aG docker $USER
echo "Added user '$USER' to the Docker group."

# Notify user to re-login
echo "You need to log out and log back in for the group membership changes to take effect."
echo "Alternatively, you can run the following command to apply changes without logging out:"
echo "    newgrp docker"

# Print success message
echo "Docker installation and configuration completed successfully."
