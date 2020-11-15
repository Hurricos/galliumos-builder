gtag := v5.9.8-galliumos
dtag := ubuntu:bionic-${gtag}-builder

image: Dockerfile
	docker build . --build-arg=gtag=${gtag} --tag $(dtag); \
	touch $@;

linux-debs.tar: image
	docker run --rm $(dtag) /bin/bash -c 'tar -cf - ../linux*deb' > $@
