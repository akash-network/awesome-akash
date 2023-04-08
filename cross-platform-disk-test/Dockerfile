FROM debian:bookworm
RUN apt-get update
RUN apt-get install -y wget unzip libgssapi-krb5-2 libicu-dev
RUN wget https://github.com/maxim-saplin/NetCoreStorageSpeedTest/releases/download/2.0.2-u/CPDT_Linux.zip
RUN unzip CPDT_Linux.zip
ENTRYPOINT ["/CPDT_Console_x64"]
