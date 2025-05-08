FROM python:3.12
RUN apt update && apt upgrade -y && apt install -y wget git libgl1 libjpeg-dev libpng-dev libglib2.0-0 && useradd -s /bin/bash -m  fcb
RUN pip install --upgrade pip

RUN git clone https://github.com/comfyanonymous/ComfyUI.git comfyui && chmod 777 -R comfyui && chown -R fcb:fcb comfyui

WORKDIR /comfyui

USER fcb

RUN python3 -m venv .venv &&\
    . .venv/bin/activate &&\
    pip install --upgrade pip &&\
    pip install -r requirements.txt &&\
    pip install -U xformers &&\
    pip install torchvision --extra-index-url https://download.pytorch.org/whl/cu121 &&\
    pip install GitPython

WORKDIR /
COPY /entrypoint.sh /comfyui/entrypoint.sh

ENTRYPOINT ["/bin/bash", "/comfyui/entrypoint.sh"]