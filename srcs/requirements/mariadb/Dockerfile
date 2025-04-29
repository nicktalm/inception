FROM debian:bullseye

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install only what's necessary
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Copy the startup script and make it executable
COPY conf/start_mariadb.sh /conf/start_mariadb.sh
RUN chmod +x /conf/start_mariadb.sh

# Use exec form of ENTRYPOINT for proper signal forwarding
ENTRYPOINT ["/conf/start_mariadb.sh"]
