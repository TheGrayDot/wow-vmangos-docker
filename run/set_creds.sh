#!/bin/bash


source .env

# Copy a template
cp run/realmd/realmd.conf.dist run/realmd/realmd.conf
cp run/mangosd/mangosd.conf.dist run/mangosd/mangosd.conf

# Update DB credentials from .env file entries
sed -i 's/DB_USER/'"$DB_USER"'/g' run/realmd/realmd.conf
sed -i 's/DB_PASSWORD/'"$DB_PASSWORD"'/g' run/realmd/realmd.conf
sed -i 's/DB_USER/'"$DB_USER"'/g' run/mangosd/mangosd.conf
sed -i 's/DB_PASSWORD/'"$DB_PASSWORD"'/g' run/mangosd/mangosd.conf
