FROM ubuntu:22.04
RUN apt-get update ; apt-get dist-upgrade -yqq ; apt-get install -y git wget unzip
RUN wget https://github.com/RavenProject/Ravencoin/releases/download/v4.6.1/raven-4.6.1-7864c39c2-x86_64-linux-gnu.tar.gz
RUN tar -zxvf raven-4.6.1-7864c39c2-x86_64-linux-gnu.tar.gz
RUN mv /raven-4.6.1-7864c39c2/bin/ravend /
RUN mv /raven-4.6.1-7864c39c2/bin/raven-cli /
RUN mkdir -p /root/.raven

EXPOSE 8766

COPY blocknotify /root/.raven/blocknotify

COPY starter.sh /

ENV PRIVATE_KEY=

ENTRYPOINT ["./starter.sh"]
