FROM ubuntu:22.04

RUN apt-get update ; apt-get dist-upgrade -yqq ; apt-get install git sudo wget libicu-dev xz-utils pciutils libnuma-dev libhwloc15 libuv1-dev libssl-dev libhwloc-dev liblzo2-dev libpam0g-dev libmicrohttpd-dev bc curl -y

#RUN git clone https://github.com/rainbowminer/RainbowMiner ; cd RainbowMiner ; chmod +x *.sh ; ./install.sh

#This removes deviceparams requirements
#RUN git clone https://github.com/rainbowminer/RainbowMiner ; cd RainbowMiner ; sed -i 's/$($DeviceParams)//g' ./Miners/*.ps1 ; chmod +x *.sh ; ./install.sh

RUN git clone https://github.com/rainbowminer/RainbowMiner ; cd RainbowMiner ; sed -i 's/\$Session.Config.CPUMiningThreads/#$Session.Config.CPUMiningThreads/g' ./Modules/Core.psm1 ; chmod +x *.sh ; ./install.sh

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
