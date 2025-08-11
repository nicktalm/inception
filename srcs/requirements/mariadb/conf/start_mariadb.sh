#!/bin/bash

# Check if required environment variables are set
if [ -z "$MARIADB_DATABASE" ] || [ -z "$MARIADB_USER" ] || [ -z "$MARIADB_PASSWORD" ] || \
   [ -z "$WORDPRESS_ADMIN_USER" ] || [ -z "$WORDPRESS_ADMIN_PASSWORD" ] || [ -z "$WORDPRESS_ADMIN_EMAIL" ] || \
   [ -z "$WORDPRESS_TEST_USER" ] || [ -z "$WORDPRESS_TEST_USER_PASSWORD" ] || [ -z "$WORDPRESS_TEST_USER_EMAIL" ]; then
	echo "Error: Required environment variables are not set."
	exit 1
fi

# Initialize the database if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
	mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null 2>&1
fi

# Start MariaDB in safe mode
mysqld_safe --bind-address=0.0.0.0 &
sleep 10

# Wait until MariaDB is ready
until mysqladmin ping --silent; do
	sleep 2
done

# Run setup only if it hasn't been done before

if [ ! -f /var/lib/mysql/.setup_done ]; then
	mysql -u root <<MYSQL_SCRIPT
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
	CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
	CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
	GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';
	FLUSH PRIVILEGES;
MYSQL_SCRIPT

	touch /var/lib/mysql/.setup_done # Mark setup as done
fi

wait