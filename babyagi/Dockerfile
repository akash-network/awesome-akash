FROM python:3.11-slim

ENV PIP_NO_CACHE_DIR=true
WORKDIR /app
RUN apt-get update && apt-get install build-essential wget curl git -y

COPY entrypoint.sh .
EXPOSE 8080

RUN wget https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz
RUN tar -zxvf gotty_2.0.0-alpha.3_linux_amd64.tar.gz ; chmod +x gotty ; rm -rf gotty_2.0.0-alpha.3_linux_amd64.tar.gz ; mv gotty /usr/local/bin

ENTRYPOINT ["bash", "/app/entrypoint.sh"]
