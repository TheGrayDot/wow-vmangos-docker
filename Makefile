include .env

prepare_build:
	docker compose --file docker-compose_prepare.yml up --build

prepare_stop:
	docker compose --file docker-compose_prepare.yml stop

prepare_clean:
	docker compose --file docker-compose_prepare.yml down \
	docker image rm wow-vmangos-docker-resources:latest

prepare_clean_volumes:
	sudo rm -rf ./volumes/resources/db/*; \
	sudo rm -rf ./volumes/resources/extractors/*; \
	sudo rm -rf ./volumes/resources/mangosd/*; \
	sudo rm -rf ./volumes/resources/realmd/*

prepare_base_build:
	docker build -t vmangos-base:${VMANGOS_COMMIT_ID} -f ./prepare/base/Dockerfile .

prepare_resources_build:
	docker build -t vmangos-resources -f ./prepare/resources/Dockerfile .

prepare_resources_run:
	docker run --name vmangos-resources vmangos-resources

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

run_ip_address:
	docker network inspect wow-vmangos-docker_frontend | grep -A3 "vmangos_realmd"
