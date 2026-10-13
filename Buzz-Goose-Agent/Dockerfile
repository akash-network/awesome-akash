# ── Stage 1: Builder (buzz-acp, buzz-cli) ────────────────────────────────────
# Rust version matches block/buzz's rust-toolchain.toml.
FROM rust:1.95-bookworm AS builder

# Buzz release to build. Keep it in step with the relay you connect to.
ARG BUZZ_REF=v0.5.2

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    pkg-config \
    libssl-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

RUN git clone --depth=1 --branch "${BUZZ_REF}" https://github.com/block/buzz.git .

RUN cargo build --release --locked \
    -p buzz-acp \
    -p buzz-cli \
    && strip target/release/buzz-acp \
    && strip target/release/buzz


# ── Stage 2: goose ───────────────────────────────────────────────────────────
# Take the binary from the official goose image rather than a curl | bash
# install, so the version is pinned and the build is reproducible.
FROM ghcr.io/aaif-goose/goose:v1.50.1 AS goose


# ── Stage 3: Runtime ─────────────────────────────────────────────────────────
FROM ubuntu:24.04

# Same runtime libraries as the official goose image.
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libssl3 \
    libdbus-1-3 \
    libgomp1 \
    libxcb1 \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/target/release/buzz-acp /usr/local/bin/buzz-acp
COPY --from=builder /build/target/release/buzz     /usr/local/bin/buzz
COPY --from=goose   /usr/local/bin/goose           /usr/local/bin/goose

WORKDIR /workspace

# goose is buzz-acp's default agent: it is spawned as `goose acp`, which loads
# the developer extension by default. Set explicitly for readability.
ENV BUZZ_ACP_AGENT_COMMAND=goose

ENTRYPOINT ["/usr/local/bin/buzz-acp"]
