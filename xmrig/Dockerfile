FROM alpine:edge

ENV POOL=pool.hashvault.pro:443
ENV WALLET=
ENV PASS=x
ENV WORKER=akash
ENV TLS=true
ENV TLS_FINGERPRINT=420c7850e09b7c0bdcf748a7da9eb3647daf8515718f36d9ccfdd6b9ff834b14
ENV ALGO=rx/0
ENV DONATE_LEVEL=0
ENV RANDOMX_MODE=
ENV CUSTOM_OPTIONS=
ENV AKASH_PROVIDER_STARTUP_CHECK=true

RUN apk --no-cache upgrade && \
    apk --no-cache add \
    util-linux \
    git \
    bash \
    hwloc-dev \
    openssl-dev \
    cmake \
    libuv-dev \
    build-base && \
    git clone https://github.com/xmrig/xmrig && \
    cd xmrig && \
    sed -i 's/constexpr const int kDefaultDonateLevel = 1;/constexpr const int kDefaultDonateLevel = '0';/g' src/donate.h && \
    sed -i 's/constexpr const int kMinimumDonateLevel = 1;/constexpr const int kMinimumDonateLevel = '0';/g' src/donate.h && \
    mkdir build && \
    cmake -DCMAKE_BUILD_TYPE=Release . && \
    make -j$(nproc) && \
    apk del \
	  git \
    build-base \
    cmake

RUN chmod +x xmrig
COPY ./run.sh /xmrig/

CMD ["./xmrig/run.sh"]
