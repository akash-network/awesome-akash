FROM ubuntu:22.04
RUN TZ=Europe/London && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt upgrade -y && apt -y install --no-install-recommends wget nginx ca-certificates ssh runit
COPY ./run.sh /
RUN sed -i 's/\r$//' /run.sh
ENTRYPOINT ["bash", "/run.sh"]
