FROM python:3.8

RUN apt update && apt upgrade -y && apt install -y wget git libgl1 libglib2.0-0 && useradd -s /bin/bash -m  fcb

RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu118 xformers
RUN git clone https://github.com/comfyanonymous/ComfyUI.git comfyui && chmod 777 -R comfyui && chown -R fcb:fcb comfyui
RUN pip install -r comfyui/requirements.txt

WORKDIR /
COPY /entrypoint.sh /entrypoint.sh
USER fcb
ENTRYPOINT ["bash", "/entrypoint.sh"]