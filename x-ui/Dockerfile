FROM ubuntu:22.04
LABEL maintainer="decloudlab@gmail.com"
LABEL description="Decloud Nodes Lab"
LABEL site="https://declab.pro"
LABEL version="v2.3.12"
RUN  apt-get update && apt-get install -y wget tar tzdata dpkg
RUN TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN wget https://github.com/MHSanaei/3x-ui/releases/download/v2.3.12/x-ui-linux-amd64.tar.gz &&\
	tar -xzvf x-ui-linux-amd64.tar.gz && rm -r x-ui-linux-amd64.tar.gz &&\
	apt-get clean && rm -rf /var/lib/apt/lists/*
COPY ./run.sh /run.sh
RUN sed -i 's/\r//' /run.sh && chmod +x /run.sh
WORKDIR /x-ui
# Run x-ui
CMD ["/run.sh"]
