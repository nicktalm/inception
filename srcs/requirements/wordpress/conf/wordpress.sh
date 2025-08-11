#!/bin/bash

# Check if WordPress is already configured
if [ ! -f /var/www/html/wp-config.php ]; then
	# Remove any existing files in the web directory
	rm -rf /var/www/html/*

	# Set ownership of the web directory to the web server user
	chown -R www-data:www-data /var/www/html

	# Download and extract the latest WordPress version
	wget https://wordpress.org/latest.tar.gz
	tar -xzf latest.tar.gz
	mv wordpress/* /var/www/html/
	rm -rf latest.tar.gz wordpress

	# Download WP-CLI (WordPress Command Line Interface)
	cd /var/www/html
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar

	# Create the WordPress configuration file
	./wp-cli.phar config create \
		--dbname=$MARIADB_DATABASE \
		--dbuser=$MARIADB_USER \
		--dbpass=$MARIADB_PASSWORD \
		--dbhost="mariadb" \
		--allow-root

	# Prevent insecure admin usernames
	if [[ $WORDPRESS_ADMIN_USER == *admin* || $WORDPRESS_ADMIN_USER == *Admin* ]]; then
		echo "Der Admin-Benutzername darf nicht 'admin' oder 'Admin' enthalten."
		exit 1
	fi

	# Install WordPress with the provided admin credentials
	./wp-cli.phar core install \
		--url=localhost \
		--title=inception \
		--admin_user=$WORDPRESS_ADMIN_USER \
		--admin_password=$WORDPRESS_ADMIN_PASSWORD \
		--admin_email=$WORDPRESS_ADMIN_EMAIL \
		--allow-root

	# Create a test user with author role
	./wp-cli.phar user create \
		$WORDPRESS_TEST_USER \
		$WORDPRESS_TEST_USER_EMAIL \
		--user_pass=$WORDPRESS_TEST_USER_PASSWORD \
		--role=author \
		--path=/var/www/html/ \
		--allow-root

	# Activate the default WordPress theme
	./wp-cli.phar theme activate twentytwentyfour --allow-root
fi

# Update PHP-FPM configuration to listen on all interfaces
sed -i 's/listen = .*/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf

# Start PHP-FPM in the foreground
php-fpm7.4 -F