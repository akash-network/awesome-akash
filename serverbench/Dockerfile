FROM debian:bookworm
RUN apt-get update ; apt-get install -y wget iputils-ping procps
COPY run.sh /
COPY serverbench.sh /
ENTRYPOINT ["sh","./run.sh"]

