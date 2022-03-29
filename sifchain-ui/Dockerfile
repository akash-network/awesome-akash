FROM nginx:stable-alpine
RUN apk update
RUN apk add tar jq runit socklog openssl
RUN openssl req -x509 -nodes -days 3650 -subj "/" -newkey rsa:4096 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt;
#RUN openssl req -x509 -nodes -days 3650 -subj "/CN=mydomain.com" -addext "subjectAltName=DNS:mydomain.com" -newkey rsa:4096 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt;
RUN rm -rf /etc/service
COPY service /etc/service
COPY default.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT runsvdir -P /etc/service
# TODO: runsvdir expects SIGTERM, so Ctrl+C (SIGINT) won't work.

EXPOSE 80
EXPOSE 443

# Labels
ARG DATE
LABEL org.opencontainers.image.title="sifchain-ui"
LABEL org.opencontainers.image.description="Sifchain is the omni-chain decentralized exchange (DEX), unlocking liquidity in various chains to free people from egregious fees and inefficient trades."
LABEL org.opencontainers.image.authors="andrey.arapov@nixaid.com"
LABEL org.opencontainers.image.created=$DATE
LABEL org.opencontainers.image.source=https://github.com/ovrclk/awesome-akash.git
# Ref. https://github.com/opencontainers/image-spec/blob/main/annotations.md
