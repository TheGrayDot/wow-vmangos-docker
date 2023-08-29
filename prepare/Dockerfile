ARG VMANGOS_COMMIT_ID

FROM vmangos-base:${VMANGOS_COMMIT_ID}

ARG VMANGOS_COMMIT_ID
ARG VMANGOS_PATCH
ARG PREPARE_CORES

# Install vmangos requirements
RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  git \
  curl \
  p7zip-full \
  && rm -rf /var/lib/apt/lists/*

# Download vmangos database repo
WORKDIR /vmangos
# RUN git clone --depth=1 https://github.com/brotalnia/database database; exit 0
# OR Download latest release
RUN curl -L -O https://raw.githubusercontent.com/brotalnia/database/master/world_full_14_june_2021.7z

# Extract database file
RUN 7z e -y world_full_14_june_2021.7z

# Clone vmangos core repo
WORKDIR /vmangos
# RUN git clone -b development --depth=1 https://github.com/vmangos/core.git core; exit 0
RUN git clone -b development https://github.com/vmangos/core.git core; exit 0
# Uncomment line, and add commit hash to build specific commit
WORKDIR /vmangos/core
RUN git checkout ${VMANGOS_COMMIT_ID}

# Make folder structure for compiling
WORKDIR /vmangos/core
RUN mkdir build; exit 0
RUN mkdir _install; exit 0

# Compile vmangos core
WORKDIR /vmangos/core/build
RUN cmake ../ \
    -DCMAKE_INSTALL_PREFIX=../_install \
    -DWITH_WARNINGS=0 \
    -DSUPPORTED_CLIENT_BUILD=${VMANGOS_PATCH} \
    -DUSE_EXTRACTORS=1
RUN make -j${PREPARE_CORES}
RUN make install

# Prepare database
WORKDIR /vmangos/core/sql/migrations/
RUN sh merge.sh

# Add resource copying script
WORKDIR /vmangos
COPY --chmod=755 ./copy_resources.sh .
CMD ["bash", "copy_resources.sh"]
