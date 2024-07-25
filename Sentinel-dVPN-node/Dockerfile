# Use a base image
FROM ubuntu:22.04

# Set timezone
ENV TZ=Europe/London 
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git curl wget make gcc libtool build-essential libssl-dev libexpat1-dev bison flex tar unzip && \
    rm -rf /var/lib/apt/lists/*

# Install Go
RUN wget https://go.dev/dl/go1.19.4.linux-amd64.tar.gz && \
    rm -rf /usr/local/go && \
    tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz && \
    ln -s /usr/local/go/bin/go /usr/bin/go && \
    rm -vf go1.19.4.linux-amd64.tar.gz

# Install v2ray
WORKDIR /root/v2ray
RUN wget https://github.com/v2fly/v2ray-core/releases/download/v5.3.0/v2ray-linux-64.zip && \
    unzip v2ray-linux-64.zip && \
    rm -vf v2ray-linux-64.zip

# Install unbound
WORKDIR /tmp
RUN git clone https://github.com/NLnetLabs/unbound.git && \
    cd unbound && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/*

# Install dvpn-node
WORKDIR /tmp
RUN git clone https://github.com/sentinel-official/dvpn-node && \
    cd dvpn-node && \
    git checkout v0.7.1 && \
    make install && \
    rm -rf /tmp/*

# Copy the main script and set CMD
COPY ./main.sh /
RUN sed -i 's/\r//' /main.sh && chmod +x /main.sh
CMD ["/main.sh"]
