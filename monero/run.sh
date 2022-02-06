FROM  alpine:edge
RUN   adduser -S -D -H -h /xmrig miner
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        git \
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
      make -j16 && \
      apk del \
	git \
        build-base \
        cmake 
        

ENV POOL=pool.hashvault.pro:443
ENV ADDRESS=solo:4AbG74FRUHYXBLkvqM1f7QH3UXGkhLetKdxS7U7BHkyfMF4nfx99GvN1REwYQHAeVLLy4Qa5gXXkfS4pSHHUWwdVFifDo5K
ENV PASSWORD=
ENV WORKER="akash"
ENV TLS=true
ENV TLS_FINGERPRINT=420c7850e09b7c0bdcf748a7da9eb3647daf8515718f36d9ccfdd6b9ff834b14
ENV ALGO=rx/0
ENV DONATE_LEVEL=0
ENV RANDOMX_MODE=auto
ENV RANDOMX_1GB=true
USER miner
RUN export POOL
WORKDIR    /xmrig

CMD exec ./xmrig -a ${ALGO} --url ${POOL} --user ${ADDRESS} --rig-id ${WORKER} --pass ${WORKER} --http-host 0.0.0.0 --http-port 8080 --no-huge-pages
# --tls --tls-fingerprint
