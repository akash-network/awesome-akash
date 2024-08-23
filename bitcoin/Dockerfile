# Use a base image
FROM ubuntu:22.04
LABEL maintainer="decloudlab@gmail.com"
LABEL description="Decloud Nodes Lab"
LABEL site="https://declab.pro"
# Set timezone
ENV TZ=Europe/London 
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# Install necessary packages
RUN apt update && apt upgrade -y &&\
    apt install -y wget tar lz4 &&\
	rm -rf /var/lib/apt/lists/*
COPY ./init.sh /init.sh
RUN sed -i 's/\r//' /init.sh && chmod +x /init.sh
ENTRYPOINT ["/init.sh"]
