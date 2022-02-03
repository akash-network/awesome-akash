FROM busybox
RUN wget https://github.com/vidulum/mainnet/releases/download/v1.0.0/vidulum_linux_amd64.tar.gz && \
    tar xvf vidulum_linux_amd64.tar.gz -C /bin && \
    rm -f vidulum_linux_amd64.tar.gz
ADD https://raw.githubusercontent.com/vidulum/mainnet/main/genesis.json /root/.vidulum/config/

CMD vidulumd start --p2p.persistent_peers "209688f5bccb88f6397a97cc11ab545a014aa559@137.184.92.115:26656,d45e9dd8878d7c22d59ded3557f61da37420a4c6@95.217.118.211:26656,cae7d9d21c1752300277eab72d861b0c6638b2e3@164.68.119.151:26656,7a44ea6ecb59b0e4bd01b58a75163ec64b164bb4@63.210.148.24:26656,3bf3d98dfd4000dd5ff8189882a9f96848b99b87@137.220.60.196:26656,057fa262fe2030cc6e9095dc52d15b79ffcb923d@142.115.20.25:26656" --rpc.laddr "tcp://0.0.0.0:26657" --p2p.seeds "883ec7d5af7222c206674c20c997ccc5c242b38b@3.82.120.39:26656"

EXPOSE 26656/tcp
EXPOSE 26657/tcp
