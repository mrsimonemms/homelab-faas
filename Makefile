STACK ?= func

all: build-fns deploy-armhf

build-fns:
	make --file=./functions/Makefile all
.PHONY: build-fns

deploy-armhf:
	docker stack deploy ${STACK} --compose-file docker-compose.armhf.yml
.PHONY: deploy-armhf

destroy-armhf:
	docker stack rm ${STACK}
.PHONY: destroy-armhf
