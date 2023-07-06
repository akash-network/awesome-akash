# FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime
# pull from devel image instead of base
# FROM nvidia/cuda:11.7.1-devel-ubuntu22.04
# FROM nvidia/cuda:12.1.0-devel-ubuntu22.04
FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04

# Set bash as the default shell
ENV SHELL=/bin/bash

# Create a working directory
WORKDIR /app/

# Build with some basic utilities
RUN apt-get update && apt-get install -y \
    python3-pip \
    apt-utils \
    vim \
    git

# alias python='python3'
RUN ln -s /usr/bin/python3 /usr/bin/python

# build with some basic python packages
RUN pip install --pre torch torchtext torchaudio torchvision --index-url https://download.pytorch.org/whl/nightly/cu121
RUN pip install \
    numpy \
    jupyterlab \
    nbconvert
# start jupyter lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]
EXPOSE 8888

# FROM tverous/pytorch-notebook:latest
RUN git clone https://github.com/pytorch/benchmark
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get install -y pandoc texlive-xetex fonts-liberation texlive texlive-latex-extra  

COPY run.sh /
COPY run.sh /app/
COPY run_cpu_only.sh /app/
COPY Akash_Gpu_Benchmark_Notebook.ipynb /app/Akash_Gpu_Benchmark_Notebook.ipynb
RUN chmod 777 -R /app/
RUN chmod 777 -R "${HOME}"
RUN pip3 install seaborn nbconvert[webpdf] pyppeteer
# RUN /opt/conda/bin/python3 -m pip install torch torchaudio torchvision torchtext

# ENTRYPOINT ["sh","./run.sh"]
# ENTRYPOINT ["jupyter notebook"]

# ENTRYPOINT ["python /workspace/benchmark/install.py models hf_bert hf_Bert_large resnet50 tacotron2 && pytest /workspace/benchmark/test_bench.py -k '(hf_bert or hf_bert_Large or resnet50 or tacotron2)' --ignore_machine_config"]
# running install at run time to reduce container size from 20Gb to about 7.
# RUN cd benchmark && python install.py
