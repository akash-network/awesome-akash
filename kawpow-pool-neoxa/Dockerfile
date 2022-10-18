FROM ubuntu:22.04
RUN apt-get update ; apt-get dist-upgrade -yqq ; apt-get install -y git wget unzip
RUN wget https://github.com/NeoxaChain/Neoxa/releases/download/v1.0.3/neoxad-linux64.zip
RUN unzip neoxad-linux64.zip ; rm neoxad-linux64.zip
RUN mkdir -p /root/.neoxa

EXPOSE 9766

COPY blocknotify /root/.neoxa/blocknotify

COPY starter.sh /

ENV PRIVATE_KEY=

ENTRYPOINT ["./starter.sh"]
