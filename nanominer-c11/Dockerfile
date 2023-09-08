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
ENV CUSTOM_COMMAND=""
ENV OPTIONS=""
# Set default environment variables for the header
ENV CHECK_FOR_UPDATES=true
ENV MPORT=0
ENV NO_LOG=true
ENV WEB_PORT=9090
ENV NO_COLOR=true

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
