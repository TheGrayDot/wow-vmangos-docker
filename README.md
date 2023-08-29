# vmangos-docker

Docker Compose environment for running vmangos

## Quickstart

- Install the following:
	- Docker with Compose plugin
	- GNU make
- Copy a WoW client to:
	- `./volumes/client_files`
- Create base image
	- `make base_image`
- Prepare resources (binaries and SQL dumps)
	- `make prepare_resources`
- Extract client data:
	- `make extract_client_data`
- Build the vmangos server Docker environment
	- `make run`

## Stage 0: `base`

A base Docker image used throughout project. Has pre-installed libraries to build (compile) and run the `vmangos` project components (e.g., `mangosd` and `realmd`).

- Location: `./base`
- What: Docker image
- Run: `make base_image`
- Check: `docker image ls`

## Stage 1: `prepare`

A Docker image to run and extract resources, which:

- Downloads and compiles the `vmangos/core` repo
- Extracts the SQL database migrations
- Downloads the base `brotalnia/database` dump
- Copies all resources to volumes for later use

- Location: `./prepare`
- What: Docker image which is run
- Run: `make prepare_resources`
- Check: Review output, then check `./volumes` directory

## Stage 2: `extract`

A Docker image to extract data from client, which:

- Uses tools compiled in `prepare` stage
- Copies extracted client data to volumes for later use

**IMPORTANT!** Make sure to add the desired client to the `./volumes/client_files` folder. Paste the contents of the `"World of Warcraft"` directory in this folder. So, if you browse to the `./volumes/client_files` directory you will see `WoW.exe`, `realmlist.wtf` etc. Something like the command below will achieve what is needed:

```
cp -r /media/external/World\ of\ Warcraft/* ./volumes/client_files/
```

- Location: `./extract`
- What: Docker image which is run
- Run: `make extract_client_data`
- Check: Review output, then check `./volumes/client_data` directory

## Stage 3: `run`

A dedicated Docker Compose environment to:

- Run the game database
- Run the game server (`mangosd`) and login server (`realmd`)
