FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server mariadb-client

# Copy the startup script
COPY conf/start_mariadb.sh /
RUN chmod +x /start_mariadb.sh

# Set the startup script as the entry point
ENTRYPOINT [ "sh", "/start_mariadb.sh"]