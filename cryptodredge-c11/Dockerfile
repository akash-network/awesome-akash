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
ENV OPTIONS="--api-bind-http 0.0.0.0:4068"

RUN wget https://github.com/CryptoDredge/miner/releases/download/v0.27.0/CryptoDredge_0.27.0_cuda_11.4_linux.tar.gz
RUN tar -xzf CryptoDredge_0.27.0_cuda_11.4_linux.tar.gz ; rm CryptoDredge_0.27.0_cuda_11.4_linux.tar.gz
RUN ls -la

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
