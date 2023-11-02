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

prepare_resources_clean:
	docker container stop vmangos-resources; \
	docker container rm vmangos-resources; \
	docker image rm vmangos-resources:${VMANGOS_COMMIT_ID};

prepare_resources_clean_volumes:
	sudo rm -rf ./volumes/db/*; \
	sudo rm -rf ./volumes/extractors/*; \
	sudo rm -rf ./volumes/mangosd/*; \
	sudo rm -rf ./volumes/realmd/*;

# Stage 2: "extract" client data (OPTIONAL)
extract_client_data:
	docker build -t vmangos-extractors:${VMANGOS_COMMIT_ID} \
	--build-arg VMANGOS_COMMIT_ID=${VMANGOS_COMMIT_ID} \
	--build-arg VMANGOS_PATCH=${VMANGOS_PATCH} \
	./extract \
	&& \
	docker run --name vmangos-extractors \
	--volume ./volumes/client_files:/resources/client_files \
	--volume ./volumes/client_data:/resources/client_data \
	--volume ./volumes/extractors:/resources/extractors \
	vmangos-extractors:${VMANGOS_COMMIT_ID}

extract_client_data_clean:
	docker container stop vmangos-extractors; \
	docker container rm vmangos-extractors; \
	docker image rm vmangos-extractors:${VMANGOS_COMMIT_ID}; \
	sudo rm -rf ./volumes/client_data/*

# Stage 3: "run" the server
run_build:
	./run/set_creds.sh; \
	docker compose up --build

run_start:
	docker compose up

run_stop:
	docker compose stop

run_clean:
	docker compose down; \
	docker image rm vmangos-mangosd:${VMANGOS_COMMIT_ID}; \
	docker image rm vmangos-realmd:${VMANGOS_COMMIT_ID}; \
	docker image rm vmangos-db:${VMANGOS_COMMIT_ID};

run_clean_volumes:
	sudo rm -rf ./volumes/mysql/

# Simple shortcut to find the Docker IP address of the server
run_dump_ip_address:
	docker network inspect wow-vmangos-docker_frontend | grep -A3 "vmangos-realmd"
