FROM ubuntu

# nvm requirements
RUN apt-get update
RUN echo "y" | apt-get install curl git
# nvm env vars
RUN mkdir -p /usr/local/nvm
ENV NVM_DIR /usr/local/nvm

# IMPORTANT: set the exact version
ENV NODE_VERSION v21.7.3
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use --delete-prefix $NODE_VERSION"

# add node and npm to the PATH
ENV NODE_PATH $NVM_DIR/versions/node/$NODE_VERSION/bin
ENV PATH $NODE_PATH:$PATH

RUN npm install -g serve astro

RUN apt install inotify-tools -y
WORKDIR /app
COPY script.sh /app
RUN chmod +x script.sh

CMD ["/bin/bash", "/app/script.sh"]
