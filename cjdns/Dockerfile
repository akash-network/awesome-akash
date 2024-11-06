FROM ubuntu:22.04
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl wget tar jq && \
    rm -rf /var/lib/apt/lists/*
COPY ./init.sh /
RUN chmod +x /init.sh
CMD ["/init.sh"]
