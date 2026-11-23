FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl xz-utils \
    cmake gcc g++ make pkgconf binutils \
    libncurses-dev libssl-dev libsodium-dev libreadline-dev zlib1g-dev \
    openssl unzip goxkcdpwgen \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp/softether-src
# The bundled oqs-provider in 5.2.5191 uses obsolete liboqs HQC identifiers.
RUN curl -fsSLo softether.tar.xz https://github.com/SoftEtherVPN/SoftEtherVPN/releases/download/5.2.5191/SoftEtherVPN-5.2.5191.tar.xz \
    && tar -xJf softether.tar.xz --strip-components=1 \
    && CMAKE_FLAGS="-DOQS_ENABLE=OFF" ./configure \
    && cmake --build build --parallel 2 \
    && mkdir -p /opt/softether/vpnserver \
    && cp build/vpnserver build/vpncmd build/hamcore.se2 build/libcedar.so build/libmayaqua.so /opt/softether/vpnserver/ \
    && cd / && rm -rf /tmp/softether-src

WORKDIR /opt/softether/vpnserver
ENV LD_LIBRARY_PATH=/opt/softether/vpnserver
COPY --chmod=755 launch /launch
CMD ["/launch"]
