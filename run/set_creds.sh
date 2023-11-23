#!/bin/bash


source .env

# Configure mangosd
cp run/mangosd/mangosd.conf.dist run/mangosd/mangosd.conf
# Set DB creds
sed -i 's/DB_USER/'"$DB_USER"'/g' run/mangosd/mangosd.conf
sed -i 's/DB_PASSWORD/'"$DB_PASSWORD"'/g' run/mangosd/mangosd.conf

# Configure readlmd
cp run/realmd/realmd.conf.dist run/realmd/realmd.conf
# Set DB creds
sed -i 's/DB_USER/'"$DB_USER"'/g' run/realmd/realmd.conf
sed -i 's/DB_PASSWORD/'"$DB_PASSWORD"'/g' run/realmd/realmd.conf
