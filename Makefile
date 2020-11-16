gtag := v5.9.8-galliumos
tag_no_branch := # remove 'tag' if the remote is a WIP
dtag := ubuntu:bionic-${gtag}-builder

image: Dockerfile
	docker build . --build-arg=gtag=${gtag} --build-arg=tag_no_branch=${tag_no_branch} --tag $(dtag); \
	touch $@;

linux-debs.tar: image
	docker run --rm $(dtag) /bin/bash -c 'tar -cf - ../linux*deb' > $@
