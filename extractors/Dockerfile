FROM ubuntu:23.04

# Install vmangos requirements
RUN apt-get update \
  && apt-get install -y \
  cmake \
  git \
  g++ \
  libboost-all-dev \
  libmysql++-dev \
  && rm -rf /var/lib/apt/lists/*

# Clone cmangos-classic repo
WORKDIR /
RUN git clone https://github.com/cmangos/mangos-classic.git mangos-classic

# Make folder structure for compiling
WORKDIR /mangos-classic
RUN mkdir build; exit 0
RUN mkdir _install; exit 0

# # Compile cmangos client data extractors
WORKDIR /mangos-classic/build
RUN cmake .. \
    -DCMAKE_INSTALL_PREFIX=../_install \
    -DBUILD_GAME_SERVER=0 \
    -DBUILD_LOGIN_SERVER=0 \
    -DBUILD_PLAYERBOT=0 \
    -DBUILD_EXTRACTORS=1
RUN make -j4
RUN make install

CMD tail -f /dev/null
