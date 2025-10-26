FROM ubuntu:22.04
RUN apt-get update ; apt-get install -y zip wget curl bzip2 tar ffmpeg libsm6 libxext6
COPY entrypoint.sh /
COPY conf.json /
ENTRYPOINT ["bash", "./entrypoint.sh"]
EXPOSE 9000
