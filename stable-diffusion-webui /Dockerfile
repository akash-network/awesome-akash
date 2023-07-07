##automatic   stable-diffusion-webui

FROM library/ubuntu:20.04

RUN DEBIAN_FRONTEND=noninteractive && apt update && apt install tzdata -y

RUN apt install git python3 python3-pip python3-venv ffmpeg libsm6 libxext6 -y && apt-get clean && useradd -s /bin/bash -m  fcb

WORKDIR /

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && chmod 777 -R stable-diffusion-webui && chown -R fcb:fcb stable-diffusion-webui

USER fcb

ENV COMMANDLINE_ARGS="--listen --port=9999"

EXPOSE 9999

ENTRYPOINT ["bash", "/stable-diffusion-webui/webui.sh"]
