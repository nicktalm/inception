#!/bin/sh

set -e  # Skript bricht bei Fehler ab
set -u  # Undefinierte Variablen verursachen Fehler

# Farben für lesbare Logs (optional)
GREEN='\033[0;32m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[MariaDB] $1${NC}"
}

# Überprüfe, ob die notwendigen Umgebungsvariablen gesetzt sind
if [ -z "$MARIADB_DATABASE" ]; then
    echo "Error: MARIADB_DATABASE is not set."
    exit 1
fi

if [ -z "$MARIADB_USER" ]; then
    echo "Error: MARIADB_USER is not set."
    exit 1
fi

if [ -z "$MARIADB_PASSWORD" ]; then
    echo "Error: MARIADB_PASSWORD is not set."
    exit 1
fi

# MariaDB-Verzeichnis initialisieren
if [ ! -d "/var/lib/mysql/mysql" ]; then
    log "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null 2>&1
fi

# MariaDB im Hintergrund starten
log "Starting MariaDB..."
mysqld_safe --bind-address=0.0.0.0 &
sleep 5  # Zeit geben für Start

# Auf Verfügbarkeit warten
until mysqladmin ping --silent; do
    log "Waiting for MariaDB to be ready..."
    sleep 2
done

# Setup nur einmal durchführen
if [ ! -f /var/lib/mysql/.setup_done ]; then
    log "Setting up initial database and user..."
    mysql -u root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO '${MARIADB_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL

    touch /var/lib/mysql/.setup_done
    log "Initial setup done."
else
    log "Setup already done. Skipping."
fi

log "MariaDB is running."

# Im Vordergrund bleiben
wait
