FROM python:3.9

WORKDIR /app

RUN DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && apt-get upgrade -y
RUN apt-get install -y tzdata software-properties-common

# Install Miniconda and PyTorch + CUDA 11.8
RUN curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN sh Miniconda3-latest-Linux-x86_64.sh -b -p ./miniconda
RUN miniconda/bin/conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia

# Install required python packages
RUN pip install -U scipy sentencepiece protobuf uvicorn fastapi bitsandbytes
RUN pip install -U git+https://github.com/huggingface/transformers.git git+https://github.com/huggingface/accelerate.git

# Copy source files
COPY . /app
