FROM ubuntu:22.04
RUN apt-get update
RUN apt-get install git sudo wget libicu-dev xz-utils pciutils libnuma-dev curl -y
RUN git clone https://github.com/rainbowminer/RainbowMiner ; cd RainbowMiner ; chmod +x *.sh ; ./install.sh
ENV TERM=xterm

ENV XWP_WALLET=
ENV DOGE_WALLET=
ENV BTC_WALLET=
ENV RVN_WALLET=
ENV XMR_WALLET=
ENV POOLS=BlockMasters,Hashcryptos,ZergPool,Zpool,Icemining,Flexpool,C3pool,HeroMiners,MiningDutch,unMineable,MoneroOcean

COPY ./run.sh /run.sh
COPY ./setup.json /RainbowMiner/setup.json
#COPY ./Config/Config-original /RainbowMiner/Config
#ENTRYPOINT ["./RainbowMiner/start.sh"]
ENTRYPOINT ["./run.sh"]

