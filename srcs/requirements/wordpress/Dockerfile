FROM debian:bullseye

# Install required packages
RUN apt update && apt upgrade -y && apt install -y \
	php7.4-fpm \
	php7.4-mysqli \
	curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN mkdir /run/php/

COPY conf/wordpress.sh /wordpress.sh
RUN chmod +x /wordpress.sh

CMD ["./wordpress.sh"]