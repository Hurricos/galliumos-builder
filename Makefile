tag=ubuntu:bionic-galliumosbuilder

image: Dockerfile
	docker build . --tag $(tag); \
	touch $@;

