FROM nvidia/cuda:11.8.0-base-ubuntu20.04

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root

# Install necessary tools and clean up
RUN apt update && \
    apt -y install wget jq curl xz-utils nvidia-opencl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

ENV ALGO=
ENV WALLET_ADDRESS=
ENV POOL=
ENV PASSWORD=x
ENV OPTIONS=""

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN wget https://github.com/NebuTech/NBMiner/releases/download/v42.3/NBMiner_42.3_Linux.tgz -O /root/nbminer-linux.tgz
RUN tar --strip-components=1 -xzf /root/nbminer-linux.tgz -C /root
ENTRYPOINT /entrypoint.sh
