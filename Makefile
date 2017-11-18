ARCH := $(shell dpkg --print-architecture || true)
ARCH_DOCKER ?= ""
ARCH_TAG ?= ""
DOCKER_USER ?= "riggerthegeek"
PASSWORD_SECRET ?= "openfaas_htpasswd"
STACK ?= func
WEB_USER ?= "faas"

ifeq ($(ARCH), armhf)
ARCH_DOCKER := ".armhf"
ARCH_TAG := "-armhf"
endif

define build-function
    $(eval DIR := ./build/${1})

	rm -Rf ${DIR}
	mkdir -p ${DIR}

	# Copy the function
	cp -r ./functions/${1} ${DIR}/function

	# Copy the template
	cp -r ./template/${2}/* ${DIR}

	# Build the container
	docker build --file ${DIR}/Dockerfile${ARCH_DOCKER} --tag ${DOCKER_USER}/${1}:latest${ARCH_TAG} ${DIR}
endef

define push
	docker push ${DOCKER_USER}/${1}:latest${ARCH_TAG}
endef

all: build-fns deploy

build-fns: func-distance-finder

deploy:
	docker stack deploy ${STACK} --compose-file docker-compose${ARCH_DOCKER}.yml
.PHONY: deploy

destroy:
	docker stack rm ${STACK}
.PHONY: destroy

func-distance-finder:
	$(call build-function,distance-finder,node)
	$(call push,distance-finder)
.PHONY: func-distance-finder

gateway:
	docker build --file ./gateway/Dockerfile${ARCH_DOCKER} --tag ${DOCKER_USER}/gwnginx:latest${ARCH_TAG} ./gateway
	$(call push,gwnginx)
.PHONY: gateway

password:
	htpasswd -B -c openfaas.htpasswd ${WEB_USER}
	cat openfaas.htpasswd
.PHONY: password

password-update:
	make password

	make destroy
	docker secret rm ${PASSWORD_SECRET} || true
	docker secret create --label openfaas ${PASSWORD_SECRET} openfaas.htpasswd
	make deploy
.PHONY: password-update
