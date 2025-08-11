# Use the official Debian Bullseye image as the base
FROM debian:bullseye

# Update package lists and install MariaDB server and client
RUN apt-get update && apt-get install -y mariadb-server mariadb-client

# Copy the MariaDB startup script into the container
COPY conf/start_mariadb.sh /

# Make the startup script executable
RUN chmod +x /start_mariadb.sh

# Set the startup script as the container's entry point
ENTRYPOINT [ "sh", "/start_mariadb.sh"]