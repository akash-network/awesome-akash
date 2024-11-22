#!/bin/bash

# Get the download URL of the latest release from the Stable Diffusion UI GitHub repository
url=$(curl -sL https://api.github.com/repos/cmdr2/stable-diffusion-ui/releases/latest \
| grep -i "browser_download_url.*linux.zip" \
| cut -d : -f 2,3 \
| tr -d '"' \
| xargs)

# Download the latest release using wget
wget $url

# Extract the version number from the URL
version=$(echo $url | sed 's/.*\([0-9]\.[0-9]\.[0-9]\).*/\1/')

echo "Stable Diffusion UI version $version downloaded successfully."
unzip Easy-Diffusion-Linux.zip
echo "Starting Stable Diffusion UI."
mv conf.json ./easy-diffusion/scripts/config.json
cd easy-diffusion ; ./start.sh
