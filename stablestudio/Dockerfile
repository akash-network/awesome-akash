FROM ubuntu:20.04
RUN apt update
RUN apt install git -y
RUN git clone https://github.com/Stability-AI/StableStudio.git

RUN apt update
RUN apt install -q -y curl
RUN curl -sL "https://deb.nodesource.com/setup_14.x" | bash -
RUN apt update
RUN apt -q -y install nodejs
RUN npm install -g yarn

WORKDIR StableStudio
RUN yarn
EXPOSE 3000
ENTRYPOINT yarn dev --host 0.0.0.0
