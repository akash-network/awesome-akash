FROM alpine:3.18
LABEL maintainer="decloudlab@gmail.com"
LABEL description="Decloud Nodes Lab"
LABEL site="https://declab.pro"
LABEL version="v5.16.1"
COPY ./* /
RUN sed -i 's/\r//' /run.sh && chmod +x /run.sh
# Run v2ray
CMD ["/run.sh"]
