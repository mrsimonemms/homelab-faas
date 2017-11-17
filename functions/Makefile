ARCH := $(shell dpkg --print-architecture || true)
ARCH_DOCKER ?= ""
ARCH_TAG ?= ""
DOCKER_USER ?= "riggerthegeek"

ifeq ($(ARCH), armhf)
ARCH_DOCKER := ".armhf"
ARCH_TAG := "-armhf"
endif

define build
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

all: distance-finder

distance-finder:
	$(call build,distance-finder,node)
	$(call push,distance-finder)
.PHONY: distance-finder
