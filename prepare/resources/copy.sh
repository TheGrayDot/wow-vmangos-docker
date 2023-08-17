#!/bin/bash


SOURCE_DIR_INSTALL="/vmangos/core/_install"
SOURCE_DIR_SQL="/vmangos/core/sql"

TARGET_DIR_TOOLS="/resources/extractors"
TARGET_DIR_MANGOSD="/resources/mangosd"
TARGET_DIR_REALMD="/resources/realmd"
TARGET_DIR_SQL="/resources/db"

echo "[*] Making target directories..."
mkdir -p $TARGET_DIR_TOOLS
mkdir -p $TARGET_DIR_MANGOSD
mkdir -p $TARGET_DIR_REALMD
mkdir -p $TARGET_DIR_SQL

# Copy extraction tools
echo "[*] Copying extraction tools..."
extraction_tools=("MoveMapGen" "mapextractor" "vmap_assembler" "vmapextractor")
for extraction_tool in "${extraction_tools[@]}"; do
    cp "${SOURCE_DIR_INSTALL}/bin/$extraction_tool" \
    "${TARGET_DIR_TOOLS}/$extraction_tool"
done

# Copy database 
echo "[*] Copying database dumps..."
sql_files=("logon" "logs" "characters")
for sql_file in "${sql_files[@]}"; do
    # Copy base database dumps
    cp "${SOURCE_DIR_SQL}/${sql_file}.sql" \
    "${TARGET_DIR_SQL}/${sql_file}_base.sql"
    # Copy database migrations
    cp "${SOURCE_DIR_SQL}/migrations/${sql_file}_db_updates.sql" \
    "${TARGET_DIR_SQL}/${sql_file}_migrations.sql"
done

# Copy world database dump
cp "/vmangos/world_full_14_june_2021.sql" "${TARGET_DIR_SQL}/world_base.sql"
cp "${SOURCE_DIR_SQL}/migrations/world_db_updates.sql" "${TARGET_DIR_SQL}/world_migrations.sql"


# Copy mangosd files
echo "[*] Copying mangosd files..."
cp "${SOURCE_DIR_INSTALL}/bin/mangosd" "${TARGET_DIR_MANGOSD}/mangosd"
cp "${SOURCE_DIR_INSTALL}/etc/mangosd.conf.dist" "${TARGET_DIR_MANGOSD}/mangosd.conf"

# Copy realmd files
echo "[*] Copying realmd files..."
cp "${SOURCE_DIR_INSTALL}/bin/realmd" "${TARGET_DIR_REALMD}/realmd"
cp "${SOURCE_DIR_INSTALL}/etc/realmd.conf.dist" "${TARGET_DIR_REALMD}/realmd.conf"
