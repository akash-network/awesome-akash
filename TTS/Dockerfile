FROM ubuntu:20.04
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends gcc g++ make python3 python3-dev python3-pip python3-venv python3-wheel espeak-ng libsndfile1-dev && rm -rf /var/lib/apt/lists/*
RUN pip3 install llvmlite --ignore-installed
RUN apt install git -y
RUN apt install nvidia-cuda-toolkit -y
RUN git clone https://github.com/coqui-ai/TTS.git
WORKDIR /root
COPY . /root
RUN pip3 install torch torchaudio --extra-index-url https://download.pytorch.org/whl/cu118
RUN rm -rf /root/.cache/pip
RUN make install
ENTRYPOINT ["tts"]
CMD ["--help"]
