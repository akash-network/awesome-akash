FROM ubuntu:22.04
ENV GEEKBENCH_VERSION=5.4.4
ENV DEBIAN_FRONTEND noninteractive
WORKDIR /app
RUN dpkg --add-architecture i386 ; apt-get update ; apt-get install curl libc6:i386 libstdc++6:i386 -y ; curl http://cdn.geekbench.com/Geekbench-${GEEKBENCH_VERSION}-Linux.tar.gz | tar -xz
RUN mkdir bin ; mv Geekbench-${GEEKBENCH_VERSION}-Linux/* ./bin ; rm -rf Geekbench-${GEEKBENCH_VERSION}-Linux
RUN rm -rf /var/lib/apt/lists/* ; apt-get clean
COPY entrypoint.sh ./
ENTRYPOINT ["/app/entrypoint.sh"]
