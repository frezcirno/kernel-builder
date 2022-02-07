FROM debian:bookworm-slim

RUN apt update && apt install -y ca-certificates apt-transport-https \
        && sed -i "s|http://deb.debian.org/debian|https://mirror.sjtu.edu.cn/debian|g" /etc/apt/sources.list \
        && apt update && apt install -y bc gcc flex bison make zstd cpio pahole rsync libncurses-dev openssl libssl-dev dpkg-dev libelf-dev python3 zlib1g-dev
