FROM nvidia/cuda:11.8.0-base-ubuntu22.04

WORKDIR /root


# Install necessary tools and clean up
RUN apt update && \
    apt -y install wget jq curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

ENV ALGO=
ENV WALLET_ADDRESS=
ENV POOL=
ENV PASSWORD=x
ENV OPTIONS="--api-bind-http 0.0.0.0:4067 --api-read-only --no-nvml"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
