FROM rust:latest AS builder

RUN apt-get update

RUN apt-get install -y \
    build-essential \
    curl

RUN curl -y --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

RUN git clone https://github.com/cjdelisle/packetcrypt_rs

WORKDIR packetcrypt_rs

RUN cargo build --release --features jemalloc

FROM debian:bullseye

WORKDIR /

COPY --from=builder /packetcrypt_rs/target/release/packetcrypt .

COPY run.sh .

ENTRYPOINT [ "./run.sh" ]

ENV POOL_HOST_DEFAULT=http://pool.pkteer.com
