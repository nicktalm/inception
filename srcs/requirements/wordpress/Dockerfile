FROM debian:12

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	php-fpm \
	php-mysqli \
	curl

COPY www.conf /etc/php/8.2/fpm/pool.d/.
COPY conf/wordpress.sh .

RUN chmod +x wordpress.sh

CMD ["./wordpress.sh"]
