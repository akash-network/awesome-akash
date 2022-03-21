FROM ubuntu:20.04
RUN apt update && apt install software-properties-common -y && add-apt-repository -y ppa:bitcoin-cash-node/ppa && apt update && apt install bitcoind -y && apt clean && apt purge software-properties-common -y && apt autoremove -y
ENTRYPOINT ["bitcoind"]
EXPOSE 8332
