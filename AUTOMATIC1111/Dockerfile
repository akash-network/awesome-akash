FROM nvidia/cuda:11.7.1-base-ubuntu22.04
RUN TZ=Europe/Kiev && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt upgrade -y && apt install -y wget build-essential git make gcc nvme-cli pv unzip python3 python3-pip python3-venv libgl1-mesa-dev libglib2.0-0 libsm6 libxrender1 libxext6 pciutils
RUN pip install wheel
RUN pip install lit
ENV PYTORCH_CUDA_ALLOC_CONF=garbage_collection_threshold:0.9,max_split_size_mb:512
RUN git clone https://github.com/Dimokus88/stable-diffusion-webui.git
RUN pip install diffusers transformers accelerate scipy safetensors
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN sed -i 's/\r$//' /entrypoint.sh
ENTRYPOINT ["bash", "/entrypoint.sh"]
