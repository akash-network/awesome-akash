# Akash Plain Linux SSH Deployments

This repository contains Docker images configured for plain Linux deployments via SSH on the Akash console. These images are based on official distribution images and are configured with OpenSSH for secure SSH access.

## Available Images

### Ubuntu 24.04

- **Repository**: `ghcr.io/akash-network/ubuntu-2404-ssh`
- **Tags**: `1`, `latest`

## Common Features

- Based on official Linux distribution images.
- OpenSSH server installed and configured for SSH access.
- SSH host keys generated at build time.
- Custom entrypoint script to handle SSH public key setup.
- Ports exposed for SSH access.

## Usage

### Pull the Image

```bash
docker pull <repository>:<tag>
```

Example:
```bash
docker pull ghcr.io/akash-network/ubuntu-2404-ssh:latest
```

### Run the Container
To run the container, specify your SSH public key using the SSH_PUBKEY environment variable.
```bash
docker run -d -p 3022:22 -e "SSH_PUBKEY=$(cat ~/.ssh/id_rsa.pub)" --name my-container <repository>:<tag>
```

Example:
```bash
docker run -d -p 3022:22 -e "SSH_PUBKEY=$(cat ~/.ssh/id_rsa.pub)" --name my-ubuntu-container ghcr.io/akash-network/ubuntu-2404-ssh:latest
```

### Connect via SSH

```bash
ssh -i ~/.ssh/id_rsa -p 3022 root@localhost
```

### Building the Images
To build the images yourself, use the provided Dockerfiles:

```bash
docker build -f Dockerfile.ubuntu -t ghcr.io/akash-network/ubuntu-2404-ssh .
```