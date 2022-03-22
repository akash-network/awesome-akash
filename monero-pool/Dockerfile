# BASE IMAGE
FROM ubuntu:20.04 AS base
ARG monero_version=0.17
ENV DEBIAN_FRONTEND=noninteractive

# Environment variables
ENV MONERO_ARGS="--testnet"
ENV MONERO_WALLET_ARGS="--testnet"
ENV MONERO_POOL_WALLET="9tRe6v9cHkX7LZTS4hampTAai5kT1rLzddNkKKAiTAg1cg3GHB8zVkv8pBjQ9uzWpwQMZgxn99BDtR3Fy5HRGKURJ3AxUNH"
ENV MONERO_POOL_WALLET_SEED="swept upper silk slackens oval nostril narrate dude match pledge inwardly cuisine point soothe excess drunk mouth upgrade zero friendly catch alkaline sapling simplest upper"
ENV MONERO_FEE_WALLET="9unzQP9GZKKWgdHPkQwMFVhHMdr9EPFw4eN4gm9E58mWLorVXSLKAWkQhBSxckQwNsdnBczkeC2XBDEfgJMW2CNXNk45NDv"

RUN apt-get update

# BUILDER IMAGE
FROM base AS builder

# Build deps for Monero
RUN apt-get install -y --no-install-recommends git build-essential cmake pkg-config libssl-dev libzmq3-dev libunbound-dev libsodium-dev libunwind8-dev liblzma-dev libreadline6-dev libldns-dev libexpat1-dev libpgm-dev qttools5-dev-tools libhidapi-dev libusb-1.0-0-dev libprotobuf-dev protobuf-compiler libudev-dev libboost-chrono-dev libboost-date-time-dev libboost-filesystem-dev libboost-locale-dev libboost-program-options-dev libboost-regex-dev libboost-serialization-dev libboost-system-dev libboost-thread-dev ccache doxygen graphviz
RUN apt-get install -y ca-certificates

# Build Monero
RUN mkdir -p /root/monero
RUN cd /root/monero && git clone https://github.com/monero-project/monero.git .
RUN cd /root/monero && git checkout release-v${monero_version} && git submodule init && git submodule update
RUN cd /root/monero && make -j4 release-static

# Build deps for Monero Pool
RUN apt-get install -y liblmdb-dev libevent-dev libjson-c-dev uuid-dev xxd

# Build Monero Pool
RUN mkdir -p /root/monero-pool
RUN cd /root/monero-pool && git clone --depth=1 https://github.com/jtgrassie/monero-pool.git .
RUN cd /root/monero-pool && MONERO_ROOT=/root/monero make -j4 release

# FINAL IMAGE
FROM base

RUN apt-get install -y tini curl libgssapi-krb5-2 liblmdb0 libevent-2.1-7 libjson-c4 uuid libunbound8 libboost-filesystem1.71.0 libboost-thread1.71.0 libboost-regex1.71.0 libhidapi-libusb0 libevent-core-2.1-7 libsodium23 && apt-get clean

# Copy resulting binaries & conf to /usr/local/{bin|etc}
COPY --from=builder /root/monero/build/Linux/release-v${monero_version}/release/bin/monerod /usr/local/bin/
COPY --from=builder /root/monero/build/Linux/release-v${monero_version}/release/bin/monero-wallet-rpc /usr/local/bin/
COPY --from=builder /root/monero-pool/build/release/monero-pool /usr/local/bin/
COPY --from=builder /root/monero-pool/build/release/pool.conf /usr/local/etc/

# Copy entrypoint script to /usr/local/bin
COPY ./run.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["tini", "--", "/usr/local/bin/run.sh"]
EXPOSE 4242 4243 28092
