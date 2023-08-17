# vmangos-docker

Docker Compose environment for running vmangos

## Stage 1: `extractors`

A dedicated container to:

- Build the extraction tools and extract the files

## Stage 2: `prepare`

A dedicated Docker image/container to:

- Build the server core and extract required files
- Extract the database files

```
make prepare_build
make prepare_run
make prepare_copy
```


## Extract Client Data

A Docker solution (`./extractors`) is provided to build the WoW Vanilla (1.12) client data extractor tools. These tools are used to dump structured data from the client which is used the server. This solution uses the `cmangos` project tools, rather than `vmangos`, as I have found them more reliable. Both, the quickstart, and more detailed discussion, is provided in the following subsections:

### Quickstart

```
# Build the Docker image
cd extractors
docker build -t cmangos-classic-extractors ./

```

### Discussion

Start by building the Docker image:

```
cd extractors
docker build -t cmangos-classic-extractors ./
```

Run the Docker image with a volume attached. This volume (`/tmp/wow-1.12`) is where the WoW Vanilla 1.12 client is stored, and is mounted to: `/wow-1.12`

```
# Run the Docker image, download cmangos and compile
docker run --name cmangos-classic-extractors -v /tmp/wow-1.12:/wow-1.12 -it cmangos-classic-extractors
```

```
/mangos-classic/_install/bin/tools
chmod u+x *
root@c629778e11c7:/mangos-classic/_install/bin/tools# mkdir /wow-1.12-files

ExtractResources.sh

# Copy compiled extraction tools from the container
mkdir tools; ./copy_tools.sh
# Allow execution of extractors entry program
cd tools
sudo chown $USER:$USER *
sudo chmod +x *
# Run ExtractResources.sh script:
# Specify wow-client-folder with $1, and output folder with $2
# Otherwise copy all files to wow-client-folder root and run 
```


```
PATH_CLIENT="/home/thomas/temp/wow-1.12"
PATH_OUTPUT="/home/thomas/temp/wow-1.12-files"
mkdir $PATH_OUTPUT
```

Extract Maps + DBC using ad with high resolution. This makes the `Cameras`, "dbc"  and `maps` folders.


```
./ad -f 0 -i "$PATH_CLIENT" -o "$PATH_OUTPUT"
```

Extract vmaps using vmap_extractor with high resolution.

```
./vmap_extractor -l -d "$PATH_CLIENT/Data" -o "$PATH_OUTPUT"
```

Assemble vmaps using vmap_assembler

```
mkdir "$PATH_OUTPUT/vmaps"
./vmap_assembler "$PATH_OUTPUT/Buildings" "$PATH_OUTPUT/vmaps"
```

Extract mmaps

```
mkdir "$PATH_OUTPUT/mmaps"
./MoveMapGen --silent --configInputPath config.json --workdir "$PATH_OUTPUT" --buildGameObjects
```


root@9c9ad30c9086:/vmangos/core/_install# pwd
/vmangos/core/_install
root@9c9ad30c9086:/vmangos/core/_install# ll bin/
total 474992
drwxr-xr-x 2 root root      4096 Aug  2 19:20 ./
drwxr-xr-x 1 root root      4096 Aug  2 19:20 ../
-rwxr-xr-x 1 root root  20695608 Aug  2 19:07 MoveMapGen*
-rwxr-xr-x 1 root root 434840224 Aug  2 19:20 mangosd*
-rwxr-xr-x 1 root root    976824 Aug  2 19:06 mapextractor*
-rwxr-xr-x 1 root root   5843176 Aug  2 19:06 realmd*
-rw-r--r-- 1 root root       345 Aug  2 19:05 run-mangosd
-rwxr-xr-x 1 root root  13764504 Aug  2 19:07 vmap_assembler*
-rwxr-xr-x 1 root root  10246896 Aug  2 19:07 vmapextractor*
root@9c9ad30c9086:/vmangos/core/_install# ll etc/
total 120
drwxr-xr-x 2 root root   4096 Aug  2 19:20 ./
drwxr-xr-x 1 root root   4096 Aug  2 19:20 ../
-rw-r--r-- 1 root root 106244 Aug  2 19:05 mangosd.conf.dist
-rw-r--r-- 1 root root   6001 Aug  2 19:05 realmd.conf.dist


https://github.com/vmangos/core/blob/development/.github/workflows/db_check.yml

https://www.osrsbox.com/blog/2019/04/14/configuring-a-wow-vanilla-server-on-ubuntu-linux/


# Use Docker Compose to prepare everything
prepare:
	docker compose --file docker-compose_prepare.yml up --build

# Manually build "vmangos-base" image used multiple times
prepare_base_build:
	docker build -t vmangos-base -f ./prepare/base/Dockerfile .

# Manually build the image to extract SQL dumps, compile binaries etc.
prepare_resources_build:
	docker build -t vmangos-resources -f ./prepare/resources/Dockerfile .

# Manually run the container
prepare_resources_run:
	docker run --name vmangos-resources vmangos-resources