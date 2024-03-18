FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y git python3 aria2 && \
    apt-get clean

WORKDIR /app

COPY entrypoint.sh .
ENTRYPOINT ["bash", "/app/entrypoint.sh"]
