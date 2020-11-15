FROM ubuntu:bionic

WORKDIR /devel/linux

RUN apt update && apt install -y git gcc make libncurses-dev m4 bison flex jfsutils \
    libcrypto++6 libcrypto++-dev libfl-dev libopagent1 \
    libjvmti-oprofile0 oprofile pcmciautils quota reiserfsprogs \
    zlib1g-dev libelf-dev libssl-dev vim bc liblz4-tool dpkg-dev kmod \
    cpio rsync

# takes care of annoyances if ever using git am
RUN git config --global user.email "you@example.com" && git config --global user.name "Your Name"

ARG gtag

RUN git clone --depth 1 https://github.com/GalliumOS/linux /devel/linux && git fetch origin tag ${gtag}

RUN git checkout ${gtag}

# Patches that have not yet been committed to the remote
ADD patches.tar /devel/linux/

RUN git am *.patch

RUN galliumos/bin/apply_patches

RUN cp galliumos/config .config && make olddefconfig

ENV CPUS=24

RUN touch scripts/package/FORCE && make -j $CPUS deb-pkg
