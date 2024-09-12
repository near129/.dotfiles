FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' >/etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked <<EOF
apt-get update
apt-get install -y --no-install-recommends \
    build-essential procps curl ca-certificates file git
EOF

WORKDIR /root/.dotfiles
COPY . .

RUN --mount=type=cache,target=/root/.cache/Homebrew \
    ./scripts/install.sh --non-interactive --in-docker

ENTRYPOINT ["/home/linuxbrew/.linuxbrew/bin/zsh", "-l"]
