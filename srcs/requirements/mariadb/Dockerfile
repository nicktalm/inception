FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY conf/init.sql /etc/mysql/init.sql
COPY conf/start_mariadb.sh .

RUN mkdir /run/mysqld && chmod +x start_mariadb.sh

CMD ["./start_mariadb.sh"]