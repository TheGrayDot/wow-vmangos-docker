# vmangos-docker

Docker Compose environment for running vmangos

## Quickstart

- Install Docker and Compose plugin
- Build the "prepare" Docker environment
- `make prepare_build`
- Put client data in `./volumes/resources/client_data`
- Build the vmangos server Docker environment
- `make run_build`

## Stage 1: `prepare`

A dedicated Docker Compose environment to:

- Build a base Docker image (`vmangos-base`) with pre-installed requirements for running vmangos
- Build a Docker container to:
	- Download and compile vmangos core repo
	- Download and extract SQL database dumps
	- Download and extract SQL database migrations
	- Extract files (mangosd, realmd, conf files, SQL files)

## Stage 2: `run`

A dedicated Docker image/container to:

- Build the server core and database
- Run the game server (`mangosd`) and login server (`realmd`)
