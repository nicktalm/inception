#!/bin/bash

# if [ ! -f /var/www/html/wp-config.php ]; then

	rm -rf /var/www/html/*

	chown -R www-data:www-data /var/www/html

	wget https://wordpress.org/latest.tar.gz
	tar -xzf latest.tar.gz
	mv wordpress/* /var/www/html/
	rm -rf latest.tar.gz wordpress

	cd /var/www/html
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar

	# Entferne den Download – du hast WordPress ja schon entpackt
	# ./wp-cli.phar core download --allow-root

	./wp-cli.phar config create \
		--dbname=$MARIADB_DATABASE \
		--dbuser=$MARIADB_USER \
		--dbpass=$MARIADB_PASSWORD \
		--dbhost="mariadb" \
		--allow-root

	# Debugging
	echo "Admin-Benutzername: $WORDPRESS_ADMIN_USER"

	if [[ $WORDPRESS_ADMIN_USER == *admin* || $WORDPRESS_ADMIN_USER == *Admin* ]]; then
		echo "Der Admin-Benutzername darf nicht 'admin' oder 'Admin' enthalten."
		exit 1
	fi

	./wp-cli.phar core install \
		--url=localhost \
		--title=inception \
		--admin_user=$WORDPRESS_ADMIN_USER \
		--admin_password=$WORDPRESS_ADMIN_PASSWORD \
		--admin_email=$WORDPRESS_ADMIN_EMAIL \
		--allow-root

	./wp-cli.phar user create \
		$WORDPRESS_TEST_USER \
		$WORDPRESS_TEST_USER_EMAIL \
		--user_pass=$WORDPRESS_TEST_USER_PASSWORD \
		--role=author \
		--path=/var/www/html/ \
		--allow-root

	./wp-cli.phar theme activate twentytwentyfour --allow-root

# fi

php-fpm8.2 -F
