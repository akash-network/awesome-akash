# Use a base image
FROM nvidia/cuda:12.2.0-base-ubuntu22.04
LABEL maintainer="decloudlab@gmail.com"
LABEL description="Decloud Nodes Lab"
LABEL site="https://declab.pro"
ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN DEBIAN_FRONTEND=noninteractive
# Install necessary packages
RUN apt update && \
	apt upgrade -y && \
	apt install -y wget tzdata git python3.10-venv libgl1-mesa-dev libglib2.0-0 libsm6 libxrender1 libxext6 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
RUN useradd -s /bin/bash -m  fcb
WORKDIR /
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && chmod 777 -R stable-diffusion-webui && chown -R fcb:fcb stable-diffusion-webui
COPY ./model /usr/bin/model
RUN sed -i 's/\r//' /usr/bin/model && chmod +x /usr/bin/model
COPY ./run.sh /
RUN sed -i 's/\r//' /run.sh && chmod +x /run.sh
USER fcb
# Run stable-diffusion-webui
CMD ["/run.sh"]
