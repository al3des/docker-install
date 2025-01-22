Here’s the updated README to include the new steps for managing Docker as a non-root user:

---

# Docker Installation Script for Debian

This script automates the process of installing Docker Engine on a Debian-based system. It also configures Docker to be used by a non-root user.

## Prerequisites

- A Debian-based distribution (e.g., Debian 11/12).
- A user with `sudo` privileges.
- An internet connection to download the necessary packages.

## Script Overview

This script performs the following tasks:
1. Uninstalls any old versions of Docker.
2. Installs Docker Engine, Docker CLI, and related dependencies.
3. Configures Docker to run as a non-root user by adding the user to the Docker group.

## Usage

### 1. Download the script

Save the script as `install_docker.sh`:

```bash
wget https://example.com/install_docker.sh
```

### 2. Make the script executable

```bash
chmod +x install_docker.sh
```

### 3. Run the script

Execute the script with `sudo`:

```bash
sudo ./install_docker.sh
```

### 4. Follow the on-screen instructions

- The script will:
  - Remove any conflicting Docker versions.
  - Install Docker Engine and related components.
  - Configure your user to run Docker without needing `sudo`.

### 5. Apply group membership changes

Once the script finishes, it will prompt you to log out and log back in or run the following command to apply the Docker group changes without logging out:

```bash
newgrp docker
```

### 6. Verify the installation

You can verify that Docker is installed correctly by running the following command:

```bash
docker run hello-world
```

If everything is set up correctly, the Docker container will run and output a confirmation message.

## Manage Docker as a Non-Root User

By default, Docker requires root privileges. This script adds your user to the `docker` group, allowing you to run Docker commands without using `sudo`. Keep in mind that adding a user to the Docker group grants root-level privileges on the system. For security considerations, use this option only on trusted systems.

## Uninstall Docker

If you wish to uninstall Docker, run the following commands:

```bash
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
sudo rm /etc/apt/sources.list.d/docker.list
sudo rm /etc/apt/keyrings/docker.asc
```

## License

This script is provided under the MIT License. See [LICENSE](LICENSE) for more details.

---

This updated README reflects the new functionality for non-root user management and includes more detailed instructions for verifying and troubleshooting the installation.
