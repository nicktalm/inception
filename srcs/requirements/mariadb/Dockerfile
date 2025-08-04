FROM debian:12

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysql \
	&& chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY conf/start_mariadb.sh /conf/start_mariadb.sh

RUN chmod +x /conf/start_mariadb.sh

EXPOSE 3306

ENTRYPOINT ["/conf/start_mariadb.sh"]
