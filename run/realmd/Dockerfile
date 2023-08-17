ARG VMANGOS_COMMIT_ID 

FROM vmangos-base:${VMANGOS_COMMIT_ID}

# Configure environment variables
ENV ACE_ROOT=/usr/include/ace

WORKDIR /vmangos/realmd

# # Configure database host + creds using env vars
# RUN sed 's/Login.*/LoginDatabaseInfo = vmangos_db;3306;'"$DB_USER"';'"$DB_PASSWORD"';realmd/g' ./realmd.conf > ./realmd.conf

# Start realmd using configuration file
# CMD ./realmd -c ./realmd.conf

# Keep the container running for troubleshooting
CMD tail -f /dev/null
