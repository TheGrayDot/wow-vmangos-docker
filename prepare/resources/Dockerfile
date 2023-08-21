ARG VMANGOS_COMMIT_ID
ARG VMANGOS_PATCH

FROM vmangos-base:${VMANGOS_COMMIT_ID}

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
RUN git checkout 8a7035261655236cef6b2bfea1be7f2ceb229c6d

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
RUN make -j2
RUN make install

# Prepare database
WORKDIR /vmangos/core/sql/migrations/
RUN sh merge.sh

# Copy data copy script and run
WORKDIR /vmangos
COPY --chmod=755 ./copy.sh .
RUN bash ./copy.sh

# Keep the container running for troubleshooting
# CMD tail -f /dev/null
