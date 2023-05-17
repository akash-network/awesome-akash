FROM debian
COPY entrypoint.sh .
RUN apt-get update ; apt-get install -y aria2 curl sudo ; aria2c --out=gotty.tar.gz https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz ; tar -zxvf gotty.tar.gz ; chmod +x gotty ; rm -rf gotty.tar.gz
CMD ["bash", "./entrypoint.sh"]
