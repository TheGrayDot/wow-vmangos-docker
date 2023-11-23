#!/bin/bash


# Hardcode paths, as they are always the same in the container
CLIENT_FILES="/resources/client_files/"
CLIENT_DATA="/resources/client_data/"
EXTRACTORS="/resources/extractors/"

# Copy client data
echo "[*] Copying client data..."
cp -r $CLIENT_FILES/* /vmangos/
cp -r $EXTRACTORS/* /vmangos/
cd /vmangos

# Extract DBC + maps in high resolution
echo "[*] Extract maps..."
./mapextractor -f 0 -i . -o .

# Extarct vmaps in high resolution
echo "[*] Extract vmaps..."
./vmapextractor -l -d ./Data

# Assemble extracted vmaps
echo "[*] Assemble vmaps..."
mkdir ./vmaps
./vmap_assembler

# Extract mmaps
echo "[*] Extract mmaps..."
python3 mmap_threader.py

# Copy required files
echo "[*] Copying data..."
cp -r ./dbc "/resources/client_data/$VMANGOS_PATCH/dbc/"
cp -r ./maps /resources/client_data/
cp -r ./vmaps /resources/client_data/
cp -r ./mmaps /resources/client_data/
