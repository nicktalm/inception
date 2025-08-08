#!/bin/bash

# Environment variables (default values provided if not set)
DB_NAME=${MARIADB_DATABASE:-wordpress_db}
DB_USER=${MARIADB_USER:-wordpress_user}
DB_PASSWORD=${MARIADB_PASSWORD:-wordpress_password}
DB_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-root_password}

# Initialize MariaDB data directory if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null 2>&1
fi

# Start MariaDB in the background for initial setup
echo "Starting MariaDB..."
mysqld_safe --bind-address=0.0.0.0 &
sleep 10  # Give MariaDB time to start

# Wait until MariaDB is up and running
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

# Set up the database and user only if it hasn't been done yet
if [ ! -f /var/lib/mysql/.setup_done ]; then
    echo "Configuring MariaDB for WordPress..."
    mysql -u root <<MYSQL_SCRIPT
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
    CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
    CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
    GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';
    FLUSH PRIVILEGES;
MYSQL_SCRIPT

    touch /var/lib/mysql/.setup_done  # Prevent rerunning the setup
fi

echo "MariaDB setup complete. Running in the foreground..."

# Keep MariaDB running in the foreground
wait