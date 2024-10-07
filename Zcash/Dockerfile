FROM ubuntu:latest

# Set timezone
ENV TZ=Africa/Casablanca
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update and install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        sudo \
        nano \
        wget \
        tar \
        zip \
        unzip \
        jq \
        golang \
        ssh \
        nginx \
        build-essential \
        git \
        make \
        gcc \
        nvme-cli \
        pkg-config \
        libssl-dev \
        libleveldb-dev \
        clang \
        bsdmainutils \
        ncdu \
        apt-transport-https \
        gnupg2 \
        cron \
        runit \
        zcash

# Allow root login via SSH
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    service ssh restart

# Import Zcash repository key
RUN wget -qO - https://apt.z.cash/zcash.asc | gpg --import && \
    gpg --export 3FE63B67F85EA808DE9B880E6DEF3BAF272766C0 | apt-key add - && \
    echo "deb [arch=amd64] https://apt.z.cash/ buster main" | tee /etc/apt/sources.list.d/zcash.list && \
    apt-get update && \
    apt-get install -y zcash && \
    zcash-fetch-params && \
    mkdir -p /root/.zcash/ && \
    touch /root/.zcash/zcash.conf

# Set root password
ARG my_root_password
RUN echo "root:${my_root_password}" | chpasswd

# Expose ports
EXPOSE 22 80 8232

# Start services
CMD service nginx start && \
    runsvdir -P /etc/service && \
    while true; do \
        pidof zcashd >/dev/null ; [[ $? -ne 0 ]] && echo "Restarting Zcashd: $(date)" >> /var/log/zcashd.log && zcashd -daemon ; \
        sleep 900 ; \
    done