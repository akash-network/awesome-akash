FROM ubuntu as javascript-automation

# nvm requirements
RUN apt-get update && apt-get install -y curl git
# nvm env vars
RUN mkdir -p /usr/local/nvm
ENV NVM_DIR /usr/local/nvm

ENV DEFAULT_NODE_VERSION v20.10.0
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $DEFAULT_NODE_VERSION && nvm use --delete-prefix $DEFAULT_NODE_VERSION"

# add node and npm to the PATH
ENV NODE_PATH $NVM_DIR/versions/node/$DEFAULT_NODE_VERSION/bin
ENV PATH $NODE_PATH:$PATH

# Install global npm packages
RUN npm install -g serve astro http-server yarn pnpm

WORKDIR /app
COPY javascript/*.sh common/*.sh index.html /app/
RUN chmod +x *.sh

CMD ["/app/main.sh"]
