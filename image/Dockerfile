FROM debian:stretch-slim

RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ stretch main contrib non-free" > /etc/apt/sources.list \
&& echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list \
&& echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-backports main contrib non-free" >> /etc/apt/sources.list \
&& echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian-security stretch/updates main contrib non-free" >> /etc/apt/sources.list \
&& apt update && apt install -y bc gcc flex bison make libncurses-dev openssl libssl-dev dpkg-dev libelf-dev python3 zlib1g-dev
