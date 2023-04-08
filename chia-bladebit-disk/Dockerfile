FROM ubuntu:22.04
RUN apt-get update ; DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -yqq ; DEBIAN_FRONTEND=noninteractive apt-get install -yqq git sshpass rsync screen sudo nginx php-fpm lsb-release jq bc libgmp3-dev build-essential cmake libboost-all-dev libnuma-dev wget curl nano python3.10-venv dnsutils
RUN git clone https://github.com/prasathmani/tinyfilemanager filemanager

ENV VERSION=1.6.0
ENV BLADEBIT_VERSION=v1.2.4
ENV BLADEBIT_DISK_VERSION=v2.0.0-beta1

#Chia Chain
#RUN git clone https://github.com/Chia-Network/chia-blockchain.git -b latest --recurse-submodules && cd chia-blockchain && git checkout $VERSION && sh install.sh && . ./activate && chia init
#Bladebit
RUN git clone https://github.com/Chia-Network/bladebit.git && cd bladebit && git checkout $BLADEBIT_VERSION && mkdir -p build && cd build && cmake .. && cmake --build . --target bladebit --config Release -j $(nproc) && cd .. && cp ./build/bladebit /usr/local/bin/ && cd /
#Bladebit-disk
RUN git clone https://github.com/Chia-Network/bladebit.git bladebit-disk && cd bladebit-disk && git checkout $BLADEBIT_DISK_VERSION && mkdir -p build && cd build && cmake .. && cmake --build . --target bladebit --config Release -j $(nproc) && cd .. && cp ./build/bladebit /usr/local/bin/bladebit-disk && cd /
#Madmax
RUN git clone https://github.com/madMAx43v3r/chia-plotter madmax && cd madmax && apt install -y libsodium-dev cmake g++ git build-essential && git submodule update --init && ./make_devel.sh && cp build/chia_plot /usr/local/bin/madmax && cd /

RUN rm -rf madmax bladebit-disk bladebit

COPY sync_rclone.sh /
COPY run.sh /
COPY sync.sh /
COPY nginx.conf /
COPY config.php /
COPY cleanup.sh /
COPY nginx-default.conf /
ENV CPU_UNITS=
ENV MEMORY_UNITS=
ENV STORAGE_UNITS=
ENV KEYS=
ENV REMOTE_PORT=22
ENV REMOTE_HOST=
ENV REMOTE_PASS=
ENV REMOTE_USER=root
ENV PLOT_SIZE=32
ENV COUNT=1
ENV THREADS=10
ENV BUCKETS=256
ENV BUCKETS3=
ENV TMPDIR=/root/chia/tmp/
ENV TMPDIR2=/root/chia/final/
ENV FINALDIR=/plots/
ENV POOL_KEY=
ENV FARMERKEY=
ENV CONTRACT=
ENV RMULTI2=1
ENV PLOTTER=madmax
ENV FINAL_LOCATION=local
ENV UPLOAD_BACKGROUND=true
ENV RAMCACHE=99G
ENV JSON_RCLONE=
ENV ENDPOINT_LOCATION=google
ENV ENDPOINT_DIR=JM_1
ENV SHUFFLE_RCLONE_ENDPOINT=false
ENV SHUFFLE_RCLONE_DIR=false
ENV RCLONE=false
ENV RCLONE_EXTRA=
ENV TOTAL_UPLOADS=100
ENV TOTAL_PLOTS=
ENV JSON_SERVER=
ENV K32_SIZE=108
ENV IMPERSONATE=
ENV ALPHA=
ENV PORT=
ENV SLEEP_BEFORE_KILL=21600
#Sleep for 6 hours at the end of plotting

RUN bladebit -h
RUN bladebit-disk help diskplot
RUN madmax --help

ENTRYPOINT ["/run.sh"]
