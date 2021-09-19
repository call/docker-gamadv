.PHONY: build pull
build:
	docker build --progress=plain --no-cache -t docker-gamadv:main .
pull:
	docker pull -q ghcr.io/call/docker-gamadv:main
