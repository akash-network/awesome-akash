FROM ghcr.io/myoung34/docker-github-actions-runner:2.308.0-ubuntu-jammy

RUN apt update \
 && apt -y --no-install-recommends install \
    npm \
    lz4 \
    pv \
 && rm -rf /var/lib/apt/lists/*
