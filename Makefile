tag=ubuntu:bionic-galliumosbuilder

image: Dockerfile
	docker build . --tag $(tag); \
	touch $@;

linux-debs.tar: image
	docker run --rm $(tag) /bin/bash -c 'tar -cf - ../linux*deb' > $@
