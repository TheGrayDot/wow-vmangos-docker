include .env

# Stage 0: "base" image for reuse
base_image:
	docker build -t vmangos-base:${VMANGOS_COMMIT_ID} ./base

# Stage 1: "prepare" resources for running a server
prepare_resources:
	docker build -t vmangos-resources:${VMANGOS_COMMIT_ID} \
	--build-arg VMANGOS_COMMIT_ID=${VMANGOS_COMMIT_ID} \
	--build-arg VMANGOS_PATCH=${VMANGOS_PATCH} \
	--build-arg PREPARE_CORES=${PREPARE_CORES} \
	./prepare \
	&& \
	docker run --name vmangos-resources \
	--volume ./volumes/db:/resources/db \
	--volume ./volumes/extractors:/resources/extractors \
	--volume ./volumes/mangosd:/resources/mangosd \
	--volume ./volumes/realmd:/resources/realmd \
	vmangos-resources:${VMANGOS_COMMIT_ID}

# Stage 2: "extract" client data
extract_client_data:
	docker build -t vmangos-extractors:${VMANGOS_COMMIT_ID} \
	--build-arg VMANGOS_COMMIT_ID=${VMANGOS_COMMIT_ID} \
	./extract \
	&& \
	docker run --name vmangos-extractors \
	--volume ./volumes/client_files:/resources/client_files \
	--volume ./volumes/client_data:/resources/client_data \
	--volume ./volumes/extractors:/resources/extractors \
	vmangos-extractors:${VMANGOS_COMMIT_ID}

# "run"
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
