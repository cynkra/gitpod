# Run base script
sh $(pwd)/lib/base.sh

# clone dm repository
git clone https://github.com/r-dbi/RMariaDB

# change project directory
cd RMariaDB

## Install devtools and R dependencies
R -q -e 'pak::pak(); pak::pak(c("devtools", "languageserver", "styler"));'

## Install MariaDB server
sudo apt-get install -y mariadb-server mariadb-client

## Start MariaDB server
sudo service mysql start
