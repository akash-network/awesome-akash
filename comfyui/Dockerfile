FROM python:3.10
RUN apt update && apt upgrade -y && apt install -y wget git libgl1 libjpeg-dev libpng-dev libglib2.0-0 && useradd -s /bin/bash -m  fcb
RUN pip install --upgrade pip

RUN git clone https://github.com/comfyanonymous/ComfyUI.git comfyui && chmod 777 -R comfyui && chown -R fcb:fcb comfyui
RUN pip install -r comfyui/requirements.txt
RUN pip install -U xformers
RUN pip install torchvision --extra-index-url https://download.pytorch.org/whl/cu121
RUN pip install GitPython

RUN ln -sf /bin/bash /bin/sh
WORKDIR /
COPY /entrypoint.sh /entrypoint.sh
USER fcb
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]