FROM ubuntu:22.04

ARG RUNNER_VERSION=2.306.0
ARG RUNNER_HASH=b0a090336f0d0a439dac7505475a1fb822f61bbb36420c7b3b3fe6b1bdc4dbaa

#ENV RUNNER_GH_REPO=https://github.com/<org>/<repo>
#ENV RUNNER_GH_TOKEN=<get from https://github.com/<org>/<repo>/settings/actions/runners/new>
#ENV RUNNER_LABELS=upgrade-tester
#ENV RUNNER_NAME=upgrade-tester

RUN apt update && apt -y --no-install-recommends install \
  wget \
  curl \
  git \
  unzip \
  jq \
  make \
  lz4 \
  hub \
  ssh \
  ca-certificates \
  wget

RUN useradd -m -s /bin/bash user

USER user
RUN mkdir /home/user/actions-runner
WORKDIR /home/user/actions-runner
RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
  echo "${RUNNER_HASH}  actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" | shasum -a 256 -c && \
  tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
  rm -vf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

USER root
RUN /home/user/actions-runner/bin/installdependencies.sh

COPY run.sh /run.sh
# run.sh script:
# - runs ghrunner under a user "user"
# - runs sshd so you can ssh to your runner (until https://github.com/akash-network/support/issues/87 gets sorted) and likely to stay as it might be handy for some use-cases where SSH access is required
ENTRYPOINT ["/run.sh"]
