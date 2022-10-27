FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN set -eux; \
    apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    procps \
    curl \
    ca-certificates \
    file \
    git \
    zsh \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root/.dotfiles
COPY . .
