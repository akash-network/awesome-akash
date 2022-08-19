FROM ubuntu:22.04
RUN apt-get update ; apt-get install -y wget bc ; apt clean ; rm -rf /var/lib/apt/lists/*
ENV VERSION=v0.5.2
ENV UPLOADERS=
RUN wget https://github.com/cjdelisle/packetcrypt_rs/releases/download/packetcrypt-${VERSION}/packetcrypt-${VERSION}-linux_amd64 ; chmod +x packetcrypt-${VERSION}-linux_amd64
COPY run.sh .
ENTRYPOINT [ "./run.sh" ]
