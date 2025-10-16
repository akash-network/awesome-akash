# Build Gwan in a stock Go builder container
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq

RUN apt-get install -y wget

RUN mkdir -p /wanchain
RUN mkdir -p /wanchain/data

COPY ./entrypoint.sh /wanchain/

RUN cd /wanchain

RUN wget https://github.com/wanchain/go-wanchain/releases/download/v3.0.0/gwan-linux-amd64.tgz && \
    tar xvf gwan-linux-amd64.tgz -C /usr/local/bin/ && \
    rm -f gwan-linux-amd64.tgz

RUN cp /usr/local/bin/gwan /wanchain/

EXPOSE 8545 17717/tcp 17717/udp

ENTRYPOINT ["/wanchain/entrypoint.sh"]
