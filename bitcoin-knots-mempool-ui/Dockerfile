FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and tini
RUN apt update && \
    apt install --no-install-recommends -y ca-certificates wget curl python3 software-properties-common && \
    wget -qO /tini https://github.com/krallin/tini/releases/download/v0.19.0/tini && \
    chmod +x /tini

# Install Bitcoin Knots
RUN add-apt-repository -y ppa:luke-jr/bitcoinknots && \
    apt update && \
    apt install --no-install-recommends -y bitcoind && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Add rpcauth script
RUN curl -L https://raw.githubusercontent.com/bitcoinknots/bitcoin/refs/tags/v28.1.knots20250305/share/rpcauth/rpcauth.py -o /usr/local/bin/rpcauth.py && \
    chmod +x /usr/local/bin/rpcauth.py

# Add startup script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/tini", "--", "docker-entrypoint.sh"]
