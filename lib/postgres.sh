# Error handling
set -eux pipefail

## Install Postgres server
sudo apt-get install -y postgresql

## Start Postgres server
sudo service postgresql start

## Configure test database
sudo sudo -u postgres createuser -s $USER
createdb ${USER}
