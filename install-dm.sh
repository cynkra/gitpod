# Run base script
sh $(pwd)/lib/base.sh

# clone dm repository
git clone https://github.com/cynkra/dm

# change project directory
cd dm

## Install devtools and R dependencies
R -q -e 'pak::pak(); pak::pak(c("devtools", "languageserver", "styler"));'

## Install Postgres server
sudo apt-get install -y postgresql

## Start Postgres server
sudo service postgresql start

## Configure test database
sudo sudo -u postgres createuser -s $USER
createdb ${USER}

## Install MariaDB server
sudo apt-get install -y mariadb-server mariadb-client

## Start MariaDB server
sudo service mysql start

## Configure test database
sudo mysql -e "CREATE DATABASE IF NOT EXISTS test; ALTER DATABASE test CHARACTER SET 'utf8'; FLUSH PRIVILEGES;"
