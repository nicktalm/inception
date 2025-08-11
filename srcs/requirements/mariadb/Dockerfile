FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server mariadb-client

COPY conf/start_mariadb.sh /
RUN chmod +x /start_mariadb.sh

ENTRYPOINT [ "sh", "/start_mariadb.sh"]