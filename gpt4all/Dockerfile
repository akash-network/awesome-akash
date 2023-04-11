# Use a Linux base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y g++ git cmake wget python3 aria2 pip && \
    apt-get clean

# Clone the alpaca.cpp repository
RUN git clone https://github.com/nomic-ai/gpt4all

RUN aria2c --out=gpt4all/chat/gpt4all-lora-quantized.bin --summary-interval 5 --check-certificate=false --max-tries=99 --retry-wait=5 --always-resume=true --max-file-not-found=99 --conditional-get=true -s 8 -x 8 -k 1M -j 1 https://the-eye.eu/public/AI/models/nomic-ai/gpt4all/gpt4all-lora-quantized.bin
RUN aria2c --out=gotty.tar.gz https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz
RUN tar -zxvf gotty.tar.gz

ENTRYPOINT ["./gotty", "-w", "--random-url-length", "16", "./gpt4all/chat/gpt4all-lora-quantized-linux-x86","--model","gpt4all/chat/gpt4all-lora-quantized.bin","-t","15"]