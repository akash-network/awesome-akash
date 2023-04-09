# Use a Linux base image
FROM ubuntu:latest

# Set the working directory to /app
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y g++ git cmake wget aria2 && \
    apt-get clean

# Clone the alpaca.cpp repository
RUN git clone https://github.com/antimatter15/alpaca.cpp && \
    cd alpaca.cpp && \
    make chat && \
    cp chat ../ && \
    cd .. && \
    rm -rf alpaca.cpp

# Download the weights
RUN aria2c --out=ggml-alpaca-7b-q4.bin --summary-interval 15 --check-certificate=false --max-tries=99 --retry-wait=5 --always-resume=true --max-file-not-found=99 --conditional-get=true -s 16 -x 16 -k 1M -j 1 https://huggingface.co/Sosaka/Alpaca-native-4bit-ggml/resolve/main/ggml-alpaca-7b-q4.bin
RUN aria2c --out=gotty.tar.gz https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz
RUN tar -zxvf gotty.tar.gz ; rm -rf gotty.tar.gz

# Set the entrypoint command
ENTRYPOINT ["./gotty", "-w", "./chat","-t","15"]
