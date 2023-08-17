include .env

prepare_all:
	docker compose --file docker-compose_prepare.yml --progress plain up --build

prepare_all_clean:
	docker compose --file docker-compose_prepare.yml down

prepare_all_clean_volumes:
	sudo rm -rf ./resources/db; \
	sudo rm -rf ./resources/extractors; \
	sudo rm -rf ./resources/mangosd; \
	sudo rm -rf ./resources/realmd

prepare_base_build:
	docker build -t vmangos-base:${VMANGOS_COMMIT_ID} -f ./prepare/base/Dockerfile .

prepare_resources_build:
	docker build -t vmangos-resources -f ./prepare/resources/Dockerfile .

prepare_resources_run:
	docker run --name vmangos-resources vmangos-resources

run_build:
	docker compose --file docker-compose_run.yml --progress plain up --build

run_start:
	docker compose --file docker-compose_run.yml up

run_stop:
	docker compose --file docker-compose_run.yml stop

run_clean:
	docker compose --file docker-compose_run.yml down --volumes

run_clean_volumes:
	sudo rm -rf ./volumes
