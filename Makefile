tag=ubuntu:bionic-galliumosbuilder-5.4

image: Dockerfile
	docker build . --tag $(tag); \
	touch $@;

