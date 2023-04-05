build:
	docker compose \
	--file docker-compose_build.yml up \
	--build

run:
	docker compose \
	--file docker-compose_run.yml up

clean:
	docker compose down; \
	docker image rm ubuntu:22.04;

clean_volume:
	sudo rm -rf ./volumes/
