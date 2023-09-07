#!/bin/bash


echo "[*] init.sh"

databases=("realmd" "characters" "mangos" "logs")

# Create databases
echo "[*] Creating databases..."
for database in "${databases[@]}"; do
    mysql -u root -p$MYSQL_ROOT_PASSWORD -e \
    "CREATE DATABASE IF NOT EXISTS $database DEFAULT CHARSET utf8 COLLATE utf8_general_ci;"
done

# Create database user
echo "[*] Creating user..."
mysql -u root -p$MYSQL_ROOT_PASSWORD -e \
"CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_USER}';"
# Set password for database user
mysql -u root -p$MYSQL_ROOT_PASSWORD -e \
"SET PASSWORD FOR '${DB_USER}'@'localhost' = PASSWORD('${DB_PASSWORD}');"

# Set required permissions
echo "[*] Setting permissions..."
mysql -u root -p$MYSQL_ROOT_PASSWORD -e \
"GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER}';"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "flush privileges;"
databases=("realmd" "characters" "mangos" "logs")
for database in "${databases[@]}"; do
    mysql -u root -p$MYSQL_ROOT_PASSWORD -e \
    "GRANT ALL ON $database.* to '${DB_USER}'@'localhost' WITH GRANT OPTION;"
done
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "flush privileges;"

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

echo "[*] Setting realmd IP address..."
mysql -u root -p$MYSQL_ROOT_PASSWORD realmd -e "INSERT INTO realmlist (id, address, name) values ('1', '$SERVER_IP', 'vmangos');"

echo "[*] Performing mysql_upgrade..."
mysql_upgrade -u root -p$MYSQL_ROOT_PASSWORD

# Touch file so Docker compose heathcheck passes
echo "[*] Making service healthy..."
touch /var/lib/mysql/healthy
