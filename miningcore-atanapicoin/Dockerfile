FROM debian:11
ARG DEBIAN_FRONTEND=noninteractive
COPY ./build.sh /
COPY ./config_napi.json /config.json
COPY ./coins.json /coins.json
RUN ./build.sh
COPY ./start-pool.sh /

ENV WALLET=AX2TZeKPMbXsTdfipvXfJM4Jg1uqrix7NV
ENV FEE_WALLET=AX2TZeKPMbXsTdfipvXfJM4Jg1uqrix7NV
ENV FEE_AMOUNT=1
ENV POSTGRES_PASSWORD=

ENTRYPOINT ["./start-pool.sh"]
