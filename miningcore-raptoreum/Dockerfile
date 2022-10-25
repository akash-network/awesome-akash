FROM debian:11
ARG DEBIAN_FRONTEND=noninteractive
COPY ./build.sh /
COPY ./config_raptoreum.json /config.json
COPY ./coins.json /coins.json
RUN ./build.sh
COPY ./start-pool.sh /

ENV WALLET=
ENV FEE_WALLET=
ENV FEE_AMOUNT=1
ENV POSTGRES_PASSWORD=
ENV COINID=raptoreum-1
ENV NAME=raptoreum

ENTRYPOINT ["./start-pool.sh"]
