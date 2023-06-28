FROM ubuntu:22.04

ARG RUNNER_VERSION=2.305.0
ARG RUNNER_HASH=737bdcef6287a11672d6a5a752d70a7c96b4934de512b7eb283be6f51a563f2f

#ENV RUNNER_GH_REPO=https://github.com/<org>/<repo>
#ENV RUNNER_GH_TOKEN=<get from https://github.com/<org>/<repo>/settings/actions/runners/new>
#ENV RUNNER_LABELS=upgrade-tester
#ENV RUNNER_NAME=upgrade-tester

RUN apt update && \
  apt -y --no-install-recommends install curl git unzip jq make lz4 hub ssh ca-certificates

RUN useradd -m -s /bin/bash user

USER user
RUN mkdir /home/user/actions-runner
WORKDIR /home/user/actions-runner
RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
RUN echo "${RUNNER_HASH}  actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" | shasum -a 256 -c
RUN tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

USER root
RUN /home/user/actions-runner/bin/installdependencies.sh

COPY run.sh /run.sh
ENTRYPOINT ["/run.sh"]
