# Error handling
set -eux pipefail

## Install MariaDB server
sudo apt-get install -y mariadb-server mariadb-client

## Start MariaDB server
sudo service mysql start

## Configure test database
sudo mysql -e "CREATE DATABASE IF NOT EXISTS test; ALTER DATABASE test CHARACTER SET 'utf8'; FLUSH PRIVILEGES;"
sudo mysql -e "CREATE USER IF NOT EXISTS '$USER'@'localhost' IDENTIFIED BY ''; GRANT ALL PRIVILEGES ON *.* TO '$USER'@'localhost'; FLUSH PRIVILEGES;"
sudo mysql -D mysql < $(dirname $0)/mariadb-tz.sql
sudo mysql -e "SET GLOBAL time_zone = 'Europe/Zurich';"
