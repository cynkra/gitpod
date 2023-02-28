# Error handling
set -eux pipefail

## Install MariaDB server
sudo apt-get install -y mariadb-server mariadb-client

## Start MariaDB server
sudo service mysql start