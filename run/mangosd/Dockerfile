ARG VMANGOS_COMMIT_ID 

FROM vmangos-base:${VMANGOS_COMMIT_ID}

# Configure environment variables
ENV ACE_ROOT=/usr/include/ace

WORKDIR /vmangos/mangosd

# # Configure mangosd conf files including database host + creds using env vars
RUN sed 's/LoginDatabase.Info.*/LoginDatabase.Info = vmangos_db;3306;'"$DB_USER"';'"$DB_PASSWORD"';realmd/g' ./mangosd.conf > ./mangosd.conf
RUN sed 's/WorldDatabase.Info.*/WorldDatabase.Info = vmangos_db;3306;'"$DB_USER"';'"$DB_PASSWORD"';mangos/g' ./mangosd.conf > ./mangosd.conf
RUN sed 's/CharacterDatabase.Info.*/CharacterDatabase.Info = vmangos_db;3306;'"$DB_USER"';'"$DB_PASSWORD"';characters/g' ./mangosd.conf > ./mangosd.conf
RUN sed 's/LogsDatabase.Info.*/LogsDatabase.Info = vmangos_db;3306;'"$DB_USER"';'"$DB_PASSWORD"';logs/g' ./mangosd.conf > ./mangosd.conf

# Start mangosd using configuration file
# CMD ./mangosd -c ./mangosd.conf

# Keep the container running for troubleshooting
CMD tail -f /dev/null
