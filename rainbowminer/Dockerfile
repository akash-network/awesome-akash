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
ENV POOLS=C3pool,MoneroOcean,unMineable,ZergPool,ZergPoolCoins,Zpool,ZpoolCoins

COPY ./run.sh /run.sh
COPY ./setup.json /RainbowMiner/setup.json

ENTRYPOINT ["./run.sh"]
