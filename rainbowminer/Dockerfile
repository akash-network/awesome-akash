FROM ubuntu:22.04

RUN apt-get update ; apt-get install git sudo wget libicu-dev xz-utils pciutils libnuma-dev curl -y
RUN git clone https://github.com/rainbowminer/RainbowMiner ; cd RainbowMiner ; chmod +x *.sh ; ./install.sh
ENV TERM=xterm

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
ENV EXCLUDE_POOL_NAME=
ENV EXCLUDE_COIN=
ENV EXCLUDE_MINER_NAME=CcminerMTP,CcminerMTP10,Nsgminer
ENV POOLS=C3pool,MoneroOcean,unMineable,ZergPool,ZergPoolCoins,Zpool,ZpoolCoins


COPY ./run.sh /run.sh
COPY ./setup.json /RainbowMiner/setup.json

ENTRYPOINT ["./run.sh"]
