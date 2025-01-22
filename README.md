# docker-install

Below is a shell script (`install_docker.sh`) that automates the process of installing Docker Engine on a Debian-based system:

```bash
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
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the Docker repository
echo "Adding Docker repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index again
echo "Updating package index after adding Docker repository..."
sudo apt-get update

# Install Docker Engine and associated packages
echo "Installing Docker Engine and components..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify installation by running hello-world
echo "Verifying Docker installation..."
sudo docker run hello-world

# Print success message
echo "Docker installation completed successfully."
```

### Usage Instructions:
1. Save this script as `install_docker.sh`.
2. Make it executable:  
   ```bash
   chmod +x install_docker.sh
   ```
3. Run the script with `sudo`:
   ```bash
   sudo ./install_docker.sh
   ```

This script handles the installation prerequisites, sets up the Docker repository, and installs the Docker Engine and its associated components. It also verifies the installation by running the `hello-world` image.
