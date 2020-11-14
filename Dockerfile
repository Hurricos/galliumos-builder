FROM ubuntu:bionic

# # from https://www.kernel.org/doc/html/v4.15/process/changes.html
# GNU C               	3.2 	gcc –version
# GNU make            	3.81 	make –version
# binutils            	2.20 	ld -v
# util-linux          	2.10o 	fdformat –version
# module-init-tools   	0.9.10 	depmod -V
# e2fsprogs           	1.41.4 	e2fsck -V
# jfsutils            	1.1.3 	fsck.jfs -V
# reiserfsprogs       	3.6.3 	reiserfsck -V
# xfsprogs            	2.6.0 	xfs_db -V
# squashfs-tools      	4.0 	mksquashfs -version
# btrfs-progs         	0.18 	btrfsck
# pcmciautils         	004 	pccardctl -V
# quota-tools         	3.09 	quota -V
# PPP                 	2.4.0 	pppd –version
# isdn4k-utils        	3.1pre1 	isdnctrl 2>&1|grep version
# nfs-utils           	1.0.5 	showmount –version
# procps              	3.2.0 	ps –version
# oprofile            	0.9 	oprofiled –version
# udev                	081 	udevd –version
# grub                	0.93 	grub –version || grub-install –version
# mcelog              	0.6 	mcelog –version
# iptables            	1.4.2 	iptables -V
# openssl & libcrypto 	1.0.0 	openssl version
# bc                  	1.06.95 	bc –version
# Sphinx[1]           	1.3 	sphinx-build –version

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
