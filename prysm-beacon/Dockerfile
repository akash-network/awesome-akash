FROM ubuntu:22.04

ENV CUSTOM_COMMAND=""
ENV JWT_SECRET="5beb992771724d0c3de2684c58cfa9942a37a4b2f418f4d7259d087b57fedc0c" 

RUN apt-get update ; apt-get install -y curl sudo wget nano bmon tmate htop jq bc git gnupg
RUN curl https://raw.githubusercontent.com/prysmaticlabs/prysm/master/prysm.sh --output /prysm.sh && chmod +x /prysm.sh

COPY run.sh /

EXPOSE 4000
EXPOSE 3500
EXPOSE 13000
EXPOSE 12000

ENTRYPOINT [ "/bin/bash", "./prysm.sh" ]
#ENTRYPOINT [ "/bin/bash", "./run.sh" ]
