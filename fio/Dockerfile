FROM debian:bookworm
RUN apt-get update ; apt-get install -y fio

ENV COMMAND=
ENV TEST=
COPY run.sh /

ENTRYPOINT ["bash","/run.sh"]
