FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        ccache \
        cmake \
        curl \
        git \
        wget \
        libjpeg-dev \
        libpng-dev

RUN pip install pyyaml 
RUN git clone https://github.com/pytorch/benchmark

# running install at run time to reduce container size from 20Gb to about 7.
# RUN cd benchmark && python install.py
