ARG VMANGOS_COMMIT_ID
ARG VMANGOS_PATCH

FROM vmangos-base:${VMANGOS_COMMIT_ID}

ARG VMANGOS_PATCH
ENV VMANGOS_PATCH $VMANGOS_PATCH

RUN apt-get update && apt-get install -y \
  python3 \
  && rm -rf /var/lib/apt/lists/*

# Add data extraction script
WORKDIR /vmangos
COPY --chmod=755 ./extract_client_data.sh .
COPY --chmod=755 ./mmap_threader.py .
COPY --chmod=755 ./offmesh.txt .
COPY --chmod=755 ./config.json .

CMD ["bash", "extract_client_data.sh"]
