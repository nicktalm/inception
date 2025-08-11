# Use the official Debian Bullseye image as the base
FROM debian:bullseye

# Update package lists, upgrade existing packages, and install required dependencies
RUN apt update && apt upgrade -y && apt install -y \
	wget \
	unzip \
	php7.4-fpm \
	php7.4-imagick \
	php7.4-dom \
	php7.4-mysqli \
	php7.4-curl \
	php7.4-intl \
	php7.4-gd \
	php7.4-mbstring \
	php7.4-zip \
	curl

# Download WP-CLI (WordPress Command Line Interface), make it executable, and move it to a system path
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# Create the directory required for PHP-FPM to run
RUN mkdir /run/php/

# Copy the WordPress setup script into the container
COPY conf/wordpress.sh /wordpress.sh

# Make the WordPress setup script executable
RUN chmod +x /wordpress.sh

# Set the WordPress setup script as the default command to run
CMD ["./wordpress.sh"]