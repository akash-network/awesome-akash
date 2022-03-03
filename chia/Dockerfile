FROM ubuntu:22.04
RUN apt-get update ; DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -yqq ; DEBIAN_FRONTEND=noninteractive apt-get install -yqq git sshpass rsync screen sudo lsb-core nginx php-fpm
COPY . /
ENV KEYS=
ENV REMOTE_PORT=22
ENV REMOTE_HOST=
ENV REMOTE_PASS=
ENV REMOTE_USER=root
ENV SIZE=32
ENV COUNT=1
ENV THREADS=10
ENV BUCKETS=
ENV BUCKETS3=
ENV TMPDIR=/root/chia/tmp/
ENV TMPDIR2=/root/chia/final/
ENV FINALDIR=/root/chia/final/
ENV POOL_KEY=
ENV FARMERKEY=
ENV CONTRACT=
ENV RMULTI2=1
ENV MEMORY=4608
ENV PLOTTER=madmax
ENV REMOTE_LOCATION=

ENTRYPOINT ["/run.sh"]
