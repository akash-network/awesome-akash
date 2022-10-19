#FROM ubuntu:18.04
FROM debian:11
ARG DEBIAN_FRONTEND=noninteractive
COPY ./build.sh /
#COPY ./config_dgb.json /config.json
COPY ./config_napi.json /config.json
COPY ./coins.json /coins.json
RUN ./build.sh
COPY ./start-pool.sh /

ENV WALLET=AX2TZeKPMbXsTdfipvXfJM4Jg1uqrix7NV
ENV FEE_WALLET=AX2TZeKPMbXsTdfipvXfJM4Jg1uqrix7NV
ENV FEE_AMOUNT=1
ENV POSTGRES_PASSWORD=

ENTRYPOINT ["./start-pool.sh"]
#CMD dotnet /miningcore/build/Miningcore.dll -c /config.json
