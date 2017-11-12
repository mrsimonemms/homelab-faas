deploy-armhf:
	docker stack deploy func --compose-file docker-compose.armhf.yml
.PHONY: deploy-armhf
