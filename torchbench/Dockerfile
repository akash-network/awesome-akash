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

COPY run.sh /
ENTRYPOINT ["sh","./run.sh"]

# ENTRYPOINT ["python /workspace/benchmark/install.py models hf_bert hf_Bert_large resnet50 tacotron2 && pytest /workspace/benchmark/test_bench.py -k '(hf_bert or hf_bert_Large or resnet50 or tacotron2)' --ignore_machine_config"]
# running install at run time to reduce container size from 20Gb to about 7.
# RUN cd benchmark && python install.py
