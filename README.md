# vmangos-docker

Docker Compose environment for running vmangos

## Quickstart

- Install the following:
	- Docker with Compose plugin
	- GNU make
- Modify the environment variables:
	- `MYSQL_ROOT_PASSWORD`
	- `DB_USER`
	- `DB_PASSWORD`
	- `SERVER_IP`
- Copy a WoW client to:
	- `./volumes/client_files`
- Create base image
	- `make base_image`
- Prepare resources (binaries and SQL dumps)
	- `make prepare_resources`
- Extract client data:
	- `make extract_client_data`
- Build the vmangos server Docker environment
	- `make run_build`
- Restart the vmangos server Docker environment
	- `make run_start`

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

## Stage 2: `extract` OPTIONAL

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

- Location: `./run`
- What: Docker compose environment to run server
- Run: `make run_build`
- Check: Review Docker compose output

## Opinionated Configuration

This project is **highly opinionated**. Some examples are:

- Runs the game server, realm server and database on one system using Compose
- Have to edit the `.env` file if you want to change configuration, but is very limited
- Lots of hard-coded paths based on what I think is the best approach
- Rolls a custom client data extraction script (e.g., vmaps, mmaps)

## Volumes

A selection of volumes are used in this project - all of which are stored under the `volumes` directory in the root of the project. The table below summarises these volumes, and their use.

| Name | Use |
|---|---|
| `client_files` | The WoW client. For example, the vanilla 1.12.1 client. This needs to be copied into the folder if you want to extract client data. |
| `client_data` | Where data extracted from the WoW client lives. This is essential for the game server to run, and is used by the `vmangos-mangosd` container. |
| `db` | Database (MySQL) dumps provided with the vmangos project. These are extracted by the `extract` phase, and used by the `vmangos-db` container during the first build. |
| `mysql` | Database (MySQL) files imported from the `db` volume. Basically, this is just the game database. This allows for persistent data storage. |
| `extractors` | Client data extraction tools (e.g., vmap/mmap) are extracted and saved here from the `prepare` stage. If you choose to extract client data, these tools are used in the `vmangos-extractors` container. |
| `mangosd` | The game server binary (e.g., `mangosd` binary). |
| `realmd` | The realm binary (e.g., `realmd` binary). |
