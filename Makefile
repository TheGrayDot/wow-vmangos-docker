include .env

# Stage 1: "prepare"
# Docker environment for "preparing" resources for running a server

# Compose environment that builds a "base" image
# Then uses the "base" image to compile vmangos and prepare MySQL data
prepare_build:
	docker compose --file docker-compose_prepare.yml up --build

prepare_stop:
	docker compose --file docker-compose_prepare.yml stop

prepare_clean:
	docker compose --file docker-compose_prepare.yml down \
	docker image rm vmangos-resources:${VMANGOS_COMMIT_ID}

prepare_clean_volumes:
	sudo rm -rf ./volumes/resources/db/*; \
	sudo rm -rf ./volumes/resources/extractors/*; \
	sudo rm -rf ./volumes/resources/mangosd/*; \
	sudo rm -rf ./volumes/resources/realmd/*

# Only build the "base" preparation image
prepare_base_build:
	docker build -t vmangos-base:${VMANGOS_COMMIT_ID} \
	-f ./prepare/base/Dockerfile \
	./prepare/base

# Only build the "resources" image, only for testing
# This has no volume mounted, and manual extraction needed
prepare_resources_build:
	docker build -t vmangos-resources:${VMANGOS_COMMIT_ID} \
	--build-arg VMANGOS_COMMIT_ID=${VMANGOS_COMMIT_ID} \
	--build-arg VMANGOS_PATCH=${VMANGOS_PATCH} \
	-f ./prepare/resources/Dockerfile \
	./prepare/resources

prepare_resources_run:
	docker run --name vmangos-resources vmangos-resources

# Stage 2: "run"
# Docker environment for "running" a server

# Compose environment for managing (build, run, remove) the server
# Creates three containers (db, game server and realm server)
run_build:
	docker compose --file docker-compose_run.yml up --build

run_start:
	docker compose --file docker-compose_run.yml up

run_stop:
	docker compose --file docker-compose_run.yml stop

run_clean:
	docker compose --file docker-compose_run.yml down

run_clean_volumes:
	sudo rm -rf ./volumes/mysql

# Simple shortcut to find the Docker IP address of the server
run_dump_ip_address:
	docker network inspect wow-vmangos-docker_frontend | grep -A3 "vmangos_realmd"
