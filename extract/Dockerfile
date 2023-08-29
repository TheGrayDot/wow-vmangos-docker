ARG VMANGOS_COMMIT_ID

FROM vmangos-base:${VMANGOS_COMMIT_ID}

# Add data extraction script
WORKDIR /vmangos
COPY --chmod=755 ./extract_client_data.sh .
COPY --chmod=755 ./offmesh.txt .
COPY --chmod=755 ./config.json .
CMD ["bash", "extract_client_data.sh"]
