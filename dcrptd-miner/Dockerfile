FROM ubuntu:22.04
RUN apt-get update && apt-get install -y dotnet6 git screen
RUN git clone https://github.com/De-Crypted/dcrptd-miner ; cd dcrptd-miner ; dotnet publish -c Release -p:PublishSingleFile=true --self-contained --runtime linux-x64
COPY start.sh /
ENV WALLET=00F85BF0261CAD519A90E6B62A103E98A9A14280CA42900CE4
ENV WORKER=akash
#ENV POOL=bmb.ffmpool.com:4445
ENV POOL=bmb.crimson-pool.com:4445
ENTRYPOINT ["/bin/bash","start.sh"]
#RUN ls -la
