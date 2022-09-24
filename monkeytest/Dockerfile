FROM python
RUN apt-get update ; apt-get install -y git
RUN git clone https://github.com/thodnev/MonkeyTest
COPY run.sh /
ENTRYPOINT ["sh","./run.sh"]
