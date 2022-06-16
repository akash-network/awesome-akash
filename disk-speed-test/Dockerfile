#FROM debian:bookworm
#COPY run.sh /
#ENTRYPOINT ["./run.sh"]
FROM alpine
RUN /sbin/apk update && \
    /sbin/apk upgrade && \
    /sbin/apk add hdparm && \
    /bin/rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

ENTRYPOINT ["/sbin/hdparm"]
