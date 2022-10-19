FROM ubuntu:22.04
RUN apt-get update ; apt-get dist-upgrade -yqq ; apt-get install -y git wget unzip
RUN wget https://github.com/JustAResearcher/Meowcoin/releases/download/V1.0.3/MEOW-1.0.3-CLI-x86_64-linux-gnu.tar.gz
RUN tar -zxvf MEOW-1.0.3-CLI-x86_64-linux-gnu.tar.gz
RUN mkdir -p /root/.meowcoin

EXPOSE 9766

ENV PRIVATE_KEY=

COPY blocknotify /root/.meowcoin/blocknotify
COPY starter.sh /

ENTRYPOINT ["./starter.sh"]
