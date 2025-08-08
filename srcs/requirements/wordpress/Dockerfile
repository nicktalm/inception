FROM debian:bullseye

# Install required packages
RUN apt update && apt upgrade -y && apt install -y \
	wget \
	unzip \
	php7.4-fpm \
	php7.4-mysqli \
	php7.4-curl \
	php7.4-gd \
	php7.4-intl \
	php7.4-mbstring \
	php7.4-imagick \
	php7.4-dom \
	php7.4-zip \
	curl


# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN mkdir /run/php/

# Copy the start script
COPY conf/wordpress.sh /wordpress.sh
RUN chmod +x /wordpress.sh

CMD ["./wordpress.sh"]