##Dockerfile
FROM python:3.8
#FastChat 13B
WORKDIR /

ADD start.sh /

RUN chmod +x /start.sh && git clone https://github.com/lm-sys/FastChat.git && cd FastChat && pip3 install --upgrade pip && pip3 install -e .
RUN wget https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz && tar -zxvf gotty_2.0.0-alpha.3_linux_amd64.tar.gz && chmod +x gotty && rm -rf gotty_2.0.0-alpha.3_linux_amd64.tar.gz

ENV GOTTY_PORT 8888

ENTRYPOINT ["./gotty","-w", "/bin/bash", "/start.sh"]
