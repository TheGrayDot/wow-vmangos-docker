#!/bin/bash


echo_error () {
    echo "[*] $1"
    echo "[*] bash extract.sh <client-folder> <target-folder>"
    echo "[*] bash extract.sh \"World\ of \Warcraft\" ~/wow-vmangos-docker/volumes/resources/client_data/"
    exit 1
}

# Check user supplied 2 arguments
if (( $# < 2 )); then
    echo_error "Invalid arguments"
fi

PATH_CLIENT="$1"
PATH_OUTPUT="$2"

# Check client folder exists
if [ ! -d "$PATH_CLIENT" ]; then
    echo_error "Client folder doesn't exist"
fi

# Check for WoW.exe in client folder
if [ ! -f "$PATH_CLIENT/WoW.exe" ]; then
    echo_error "Cannot find WoW.exe in client folder"
fi

# Check target folder exists
if [ ! -d "$PATH_OUTPUT" ]; then
    echo_error "Output folder doesn't exist"
fi

# Extract DBC + maps in high resolution
./ad -f 0 -i "$PATH_CLIENT" -o "$PATH_OUTPUT"

# Extarct vmaps in high resolution
./vmap_extractor -l -d "$PATH_CLIENT/Data" -o "$PATH_OUTPUT"

# Assemble extracted vmaps
mkdir "$PATH_OUTPUT/vmaps"
./vmap_assembler "$PATH_OUTPUT/Buildings" "$PATH_OUTPUT/vmaps"

# Extract mmaps
mkdir "$PATH_OUTPUT/mmaps"
./MoveMapGen --silent --configInputPath config.json --workdir "$PATH_OUTPUT" --buildGameObjects
