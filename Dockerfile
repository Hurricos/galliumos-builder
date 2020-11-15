FROM ubuntu:bionic

WORKDIR /devel/linux
RUN apt update && apt install -y git
RUN git clone https://github.com/galliumos/linux /devel/linux && git checkout origin/v4.16.18-galliumos

RUN apt install -y gcc make libncurses-dev m4 bison \
    flex jfsutils libcrypto++6 libcrypto++-dev libfl-dev libopagent1 \
    libjvmti-oprofile0 oprofile pcmciautils quota reiserfsprogs \
    zlib1g-dev libelf-dev libssl-dev vim bc

RUN apt install -y liblz4-tool dpkg-dev

ADD .config /devel/linux/.config

ENV CPUS=24

RUN touch scripts/package/FORCE && make -j $CPUS deb-pkg
