STACK ?= func

deploy-armhf:
	docker stack deploy ${STACK} --compose-file docker-compose.armhf.yml
.PHONY: deploy-armhf

destroy-armhf:
	docker stack rm ${STACK}
.PHONY: destroy-armhf
