ARG VMANGOS_COMMIT_ID 

FROM vmangos-base:${VMANGOS_COMMIT_ID}

# Configure environment variables
ENV ACE_ROOT=/usr/include/ace

# Make directory for logs
WORKDIR /vmangos/logs

# Copy config file
WORKDIR /vmangos/etc
COPY ./mangosd.conf .

# Start realmd using configuration file
WORKDIR /vmangos/
CMD ./bin/mangosd -c ./etc/mangosd.conf

# Keep the container running for troubleshooting
# CMD tail -f /dev/null
