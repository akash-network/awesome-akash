# syntax=docker/dockerfile-upstream:experimental

FROM ubuntu:18.04 as build

RUN apt-get update -qq && apt-get install -y \
    git \
    cmake \
    g++ \
    pkg-config \
    libssl-dev \
    curl \
    llvm \
    clang \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/near/nearcore \
    && cd nearcore \
    && git fetch --all --tags --prune \
    && git checkout tags/$(curl -s https://github.com/near/nearcore/releases/latest | tr '/" ' '\n' | grep "[0-9]\.[0-9]*\.[0-9]" | head -n 1)

RUN mv nearcore near
WORKDIR /near
RUN cp rust-toolchain.toml /tmp/rust-toolchain.toml

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path --default-toolchain none

# RUN make neard

ENV CARGO_TARGET_DIR=/tmp/target
ENV RUSTC_FLAGS='-C target-cpu=x86-64'
ENV PORTABLE=ON
ARG features=default
RUN cargo build -p neard --release --features $features && \
    mkdir /tmp/build && \
    cd /tmp/target/release && \
    mv ./neard /tmp/build

# Actual image
FROM ubuntu:18.04

EXPOSE 3030 24567

RUN apt-get update -qq && apt-get install -y \
    libssl-dev ca-certificates aria2 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /tmp/build/* /usr/local/bin/
COPY run.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/run.sh

CMD ["/usr/local/bin/run.sh"]
