FROM ubuntu:22.04
RUN apt-get update && apt-get install -y dotnet6 git
RUN git clone https://github.com/De-Crypted/dcrptd-miner ; cd dcrptd-miner ; dotnet publish -c Release -p:PublishSingleFile=true --self-contained --runtime linux-x64 
RUN ls -la
