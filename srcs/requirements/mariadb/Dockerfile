FROM debian:12

RUN apt update && apt upgrade && apt install -y \
	mariadb-server

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY init.sql /etc/mysql/init.sql
COPY conf/start_mariadb.sh .

RUN mkdir /run/mysqld && chmod +x start_mariadb.sh

CMD ["./start_mariadb.sh"]