FROM nvidia/cuda:11.8.0-base-ubuntu20.04
ENV DEBIAN_FRONTEND=noninteractive
#FROM cryptoandcoffee/nvidia-docker-cuda-11-base


WORKDIR /root


# Install necessary tools and clean up
RUN apt update && \
    apt -y install wget jq curl xz-utils nvidia-opencl-dev zenity x11-apps && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

ENV ALGO=dynex
ENV WALLET_ADDRESS=Xwo146APY9sjms7pQeycGb1TRYK5NVXVQXPnD3jUyPSYByCa2y6jtq6CtKnFMNQWTYd38dPoA2eeQHx74UrJyUeK22nYtK1G1
ENV POOL=dynex.neuropool.net:19330
ENV PASSWORD=x
ENV OPTIONS="--api-host 0.0.0.0 --api-port 21550"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
