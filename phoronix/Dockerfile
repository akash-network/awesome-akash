FROM phoronix/pts
RUN uname -a

RUN apt-get update ; apt-get dist-upgrade -yqq ; apt-get install -y python3-pip
RUN pip3 install apt-select ; apt-select --country US ; cp /sources.list /etc/apt/source.list ; apt-get update
RUN apt-get install -y build-essential autoconf python3-pip python3-yaml libopenmpi-dev openmpi-bin libmpich-dev libpopt-dev libaio-dev python2-minimal npm cmake cmake-data

ENV TEST="ramspeed"
ENV COMMAND="batch-benchmark"

COPY run.sh /

ENTRYPOINT ["sh","/run.sh"]
