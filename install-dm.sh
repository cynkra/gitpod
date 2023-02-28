# Error handling
set -eux pipefail

# Run base script
sh $(pwd)/lib/base.sh

PROJECT=dm

# Clone dm repository
if ! [ -d "$PROJECT" ]; then
    git clone https://github.com/cynkra/dm $PROJECT
fi

# Go to the project directory
cd $PROJECT

## Install devtools and R dependencies
R -q -e 'pak::pak(); pak::pak(c("devtools", "languageserver", "styler"));'


# Install MariaDB script
sh $(pwd)/lib/mariadb.sh

# Install Postgres script
sh $(pwd)/lib/postgres.sh

## Configure test database
sudo sudo -u postgres createuser -s $USER
createdb ${USER}

## Configure test database
sudo mysql -e "CREATE DATABASE IF NOT EXISTS test; ALTER DATABASE test CHARACTER SET 'utf8'; FLUSH PRIVILEGES;"
