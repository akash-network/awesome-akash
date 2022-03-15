FROM ubuntu:20.04
RUN apt update && apt install software-properties-common -y && add-apt-repository -y ppa:bitcoin-cash-node/ppa && apt update && apt install bitcoind -y && apt clean && apt purge software-properties-common -y && apt autoremove -y
CMD ["bitcoind", "-server", "-rest", "-rpcallowip=0.0.0.0/0", "-rpcbind=0.0.0.0:8332", "-rpcauth=bitcoincash:60edf0daee78544880c6b3619a61c666$b06f1d8abf3df44d403b048c612c9edd6957a9477b4fa2e69242ac769187ec3a", "--prune=100000"]
EXPOSE 8332
