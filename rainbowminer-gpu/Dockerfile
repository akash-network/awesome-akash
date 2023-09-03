FROM nvidia/cuda:11.8.0-base-ubuntu20.04

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary tools and clean up
RUN apt update && \
    apt-get dist-upgrade -yqq && \
    apt -y install wget jq curl xz-utils nvidia-opencl-dev git sudo wget libicu-dev xz-utils pciutils libnuma-dev libhwloc15 libuv1-dev libssl-dev libhwloc-dev liblzo2-dev libpam0g-dev libmicrohttpd-dev bc curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/rainbowminer/RainbowMiner ; cd RainbowMiner ; git checkout v4.8.7.6 ; sed -i 's/\$Session.Config.CPUMiningThreads/#$Session.Config.CPUMiningThreads/g' ./Modules/Core.psm1 ; chmod +x *.sh ; ./install.sh

ENV TERM=xterm

ENV CUSTOM_WALLET=
ENV XWP_WALLET=
ENV DOGE_WALLET=
ENV BTC_WALLET=
ENV RVN_WALLET=
ENV XMR_WALLET=
ENV XTZ_WALLET=
ENV AECurrency=
ENV REGION=us
ENV SSL=1
ENV MINER_NAME=
ENV ALGORITHM=
ENV EXCLUDE_COIN_SYMBOL=
ENV EXCLUDE_ALGORITHM=
ENV EXCLUDE_POOL_NAME=Nicehash
ENV EXCLUDE_COIN=
ENV EXCLUDE_MINER_NAME=CcminerMTP,CcminerMTP10,Nsgminer
ENV POOLS=
ENV BENCHMARK_INTERVAL=30
ENV PROHASHING=
ENV MINING_DUTCH=
ENV DEVICE_NAME=CPU,GPU

COPY ./run.sh /run.sh
COPY ./setup.json /RainbowMiner/setup.json

ENTRYPOINT ["/run.sh"]
