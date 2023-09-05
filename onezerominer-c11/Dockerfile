FROM nvidia/cuda:11.8.0-base-ubuntu20.04

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root

RUN apt update && \
    apt -y install wget jq curl xz-utils nvidia-opencl-dev zenity x11-apps && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

ENV ALGO=
ENV WALLET_ADDRESS=
ENV POOL=
ENV PASSWORD=x
ENV OPTIONS="--api-host 0.0.0.0 --api-port 21550"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
