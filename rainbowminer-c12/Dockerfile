#FROM ubuntu:22.04
#FROM nvidia/cuda:11.8.0-base-ubuntu20.04
FROM nvidia/cuda:12.2.0-base-ubuntu22.04

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary tools and clean up
RUN apt update && \
    apt-get dist-upgrade -yqq && \
    apt -y install wget jq curl xz-utils nvidia-opencl-dev git sudo wget libicu-dev xz-utils pciutils libnuma-dev libhwloc15 libuv1-dev libssl-dev libhwloc-dev liblzo2-dev libpam0g-dev libmicrohttpd-dev bc curl git sudo wget libicu-dev xz-utils pciutils libnuma-dev libhwloc15 libuv1-dev libssl-dev libhwloc-dev liblzo2-dev libpam0g-dev libmicrohttpd-dev bc curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Run package updates and install packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common \
    && add-apt-repository -y ppa:graphics-drivers/ppa \
    && apt-get update
# Search for nvidia-utils packages
#RUN apt-cache search nvidia-utils | grep '^nvidia-utils-' | awk '{print $1}' > nvidia_utils_packages.txt

# Sort and get the most recent package
#RUN most_recent_package=$(sort -Vr nvidia_utils_packages.txt | head -n 1)

# Show the most recent package
#RUN echo "The most recent nvidia-utils package is: $most_recent_package"
#RUN sleep 30


###TEST THIS LATER
#RUN apt-get install -y nvidia-utils-535-server nvidia-cuda-toolkit libnvidia-compute-535-server

##MINERS FAILING WITHOUT THIS
#RUN apt-get install -y libssl1.0.0



#RUN git clone https://github.com/rainbowminer/RainbowMiner ; cd RainbowMiner ; chmod +x *.sh ; ./install.sh

#This removes deviceparams requirements
#RUN git clone https://github.com/rainbowminer/RainbowMiner ; cd RainbowMiner ; sed -i 's/$($DeviceParams)//g' ./Miners/*.ps1 ; chmod +x *.sh ; ./install.sh

#RUN git clone https://github.com/rainbowminer/RainbowMiner ; cd RainbowMiner ; sed -i 's/\$Session.Config.CPUMiningThreads/#$Session.Config.CPUMiningThreads/g' ./Modules/Core.psm1 ; chmod +x *.sh ; ./install.sh
#RUN git clone https://github.com/rainbowminer/RainbowMiner ; cd RainbowMiner ; ./Modules/Core.psm1 ; chmod +x *.sh ; ./install.sh

RUN git clone https://github.com/rainbowminer/RainbowMiner ; cd RainbowMiner ; chmod +x *.sh ; ./install.sh

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

COPY ./run.sh /run.sh
COPY ./setup.json /RainbowMiner/setup.json

ENTRYPOINT ["./run.sh"]
