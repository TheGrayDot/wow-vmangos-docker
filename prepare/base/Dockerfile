FROM ubuntu:22.04

# Install vmangos base requirements
# This does not include compilation packages
# Only things to run mangosd and realmd
RUN apt-get update && apt-get install -y \
  libace-dev \
  libmysql++-dev \
  openssl \
  libssl-dev \
  libtbb-dev \
  zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*
