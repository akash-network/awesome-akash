FROM ghcr.io/myoung34/docker-github-actions-runner:2.311.0-ubuntu-jammy

RUN apt update \
 && apt -y --no-install-recommends install \
    npm \
    lz4 \
    pv \
    wget \
 && rm -rf /var/lib/apt/lists/*
