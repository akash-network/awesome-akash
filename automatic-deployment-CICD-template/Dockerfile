FROM ubuntu as javascript-automation

# nvm requirements
RUN apt-get update
RUN echo "y" | apt-get install curl git
# nvm env vars
RUN mkdir -p /usr/local/nvm
ENV NVM_DIR /usr/local/nvm

# IMPORTANT: set the exact version
ENV DEFAULT_NODE_VERSION v20.10.0
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $DEFAULT_NODE_VERSION && nvm use --delete-prefix $DEFAULT_NODE_VERSION"

# add node and npm to the PATH
ENV NODE_PATH $NVM_DIR/versions/node/$DEFAULT_NODE_VERSION/bin
ENV PATH $NODE_PATH:$PATH

RUN npm install -g serve astro http-server yarn pnpm

# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#     python3 \
#     python3-pip \
#     python3.12-venv

WORKDIR /app
COPY javascript/*.sh common/*.sh index.html /app/
RUN chmod +x *.sh

#CMD /bin/bash -c "/app/js.sh | logdy --ui-ip 0.0.0.0"
CMD ["/app/main.sh"]

FROM python:3.9-alpine3.19 as python-automation

RUN apk add git bash
WORKDIR /app
COPY python/*.sh common/*.sh index.html /app/
RUN chmod +x *.sh

CMD ["bash", "/app/main.sh"]
