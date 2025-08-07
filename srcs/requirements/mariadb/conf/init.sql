CREATE DATABASE IF NOT EXISTS mariadb;
CREATE USER IF NOT EXISTS 'maria_db_user'@'%' IDENTIFIED BY 'maria_db_password';
GRANT ALL PRIVILEGES ON mariadb.* TO 'maria_db_user'@'%';
FLUSH PRIVILEGES;