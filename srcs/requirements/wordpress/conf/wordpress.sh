#!/bin/bash

# if [ ! -f /var/www/html/wp-config.php ]; then

	rm -rf /var/www/html/*

	wget https://wordpress.org/latest.tar.gz
	tar -xzf latest.tar.gz
	mv wordpress/* /var/www/html/
	rm latest.tar.gz

	cd /var/www/html
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	./wp-cli.phar core download \
			--allow-root
	./wp-cli.phar config create \
			--dbname=wordpress \
			--dbuser=wpuser \
			--dbpass=password \
			--dbhost=mariadb \
			--allow-root
	./wp-cli.phar core install \
			--url=localhost \
			--title=inception \
			--admin_user=admin \
			--admin_password=admin \
			--admin_email=admin@admin.com \
			--allow-root
	./wp-cli.phar user create \
			lasernick \
			lasernick@laser.com \
			--user_pass=megalaser \
			--role=author \
			--path=/var/www/html/ \
			--allow-root
	./wp-cli.phar theme activate twentytwentyfour \
			--allow-root
# fi

php-fpm8.2 -F