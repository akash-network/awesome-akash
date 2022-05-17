FROM phoronix/pts
RUN uname -a
#ENV PHORONIX_VERSION=10.8.3
#ENV COMMAND="batch-benchmark build-linux-kernel"
ENV COMMAND="batch-benchmark ramspeed"
#RUN apt-get update; apt-get install -y php5-cli wget
#RUN /phoronix-test-suite/phoronix-test-suite batch-setup
#RUN add-apt-repository ppa:apt-fast/stable
#RUN apt-get update ; apt-get install -y netselect-apt
#RUN add-apt-repository ppa:apt-fast/stable
#RUN echo "deb http://security.ubuntu.com/ubuntu focal-security main" >> /etc/apt/sources.list
RUN apt-get update ; apt-get install -y python3-pip
RUN pip3 install apt-select ; apt-select --country US ; cp /sources.list /etc/apt/source.list ; apt-get update
RUN apt-get install -y build-essential autoconf python3-pip python3-yaml libopenmpi-dev openmpi-bin libmpich-dev libpopt-dev libaio-dev python2-minimal npm cmake cmake-data
#RUN wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl-dev_1.1.1f-1ubuntu2_amd64.deb
#http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl-dev_1.1.1f-1ubuntu2_amd64.deb
#RUN dpkg -i libssl-dev_1.1.1f-1ubuntu2_amd64.deb
#RUN pip3 install apt-select
#RUN apt-select --country US
#RUN cp /sources.list /etc/apt/source.list
#RUN apt-get update
#RUN apt-get install -y npm
COPY run.sh /
#RUN mkdir -p /root/.phoronix-test-suite/
#COPY phoronix-test-suite.xml /phoronix-test-suite/user-config.xml
#RUN /phoronix-test-suite/phoronix-test-suite batch-setup
#CMD ["/phoronix-test-suite/phoronix-test-suite" "shell"]
ENTRYPOINT ["sh","/run.sh"]
