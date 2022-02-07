FROM debian:bullseye-slim

RUN sed -i "s|http://deb.debian.org/debian|http://mirror.sjtu.edu.cn/debian|g" /etc/apt/sources.list \
        && apt update && apt install -y bc gcc flex bison make zstd cpio kmod dwarves rsync libncurses-dev openssl libssl-dev dpkg-dev libelf-dev python3 zlib1g-dev
