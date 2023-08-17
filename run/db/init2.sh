#!/bin/bash


echo "[*] init2.sh"

echo "[*] Loading realmd base..."
mysql -u root -p$MYSQL_ROOT_PASSWORD realmd < /db/logon_base.sql
echo "[*] Loading realmd migrations..."
mysql -u root -p$MYSQL_ROOT_PASSWORD realmd < /db/logon_migrations.sql

echo "[*] Loading logs base..."
mysql -u root -p$MYSQL_ROOT_PASSWORD logs < /db/logs_base.sql
echo "[*] Loading logs migrations..."
mysql -u root -p$MYSQL_ROOT_PASSWORD logs < /db/logs_migrations.sql

echo "[*] Loading characters base..."
mysql -u root -p$MYSQL_ROOT_PASSWORD characters < /db/characters_base.sql
echo "[*] Loading characters migrations..."
mysql -u root -p$MYSQL_ROOT_PASSWORD characters < /db/characters_migrations.sql

echo "[*] Loading world base..."
mysql -u root -p$MYSQL_ROOT_PASSWORD mangos < /db/world_base.sql
echo "[*] Loading world migrations..."
mysql -u root -p$MYSQL_ROOT_PASSWORD mangos < /db/world_migrations.sql

echo "[*] Performing mysql_upgrade..."
mysql_upgrade -u root -p$MYSQL_ROOT_PASSWORD

# TODO add additional configuration

echo "[*] Making service healthy..."
# Finally touch file so Docker compose heathcheck passes
touch /var/lib/mysql/healthy
