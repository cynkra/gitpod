# Error handling
set -eux pipefail

# Folder with base scripts
LIB_FOLDER=$(dirname $0)/lib

# Run base script
sh $LIB_FOLDER/base.sh

# Clone dm repository
sh $LIB_FOLDER/repository.sh cynkra/dm

# Install MariaDB script
sh $LIB_FOLDER/mariadb.sh

# Install Postgres script
sh $LIB_FOLDER/postgres.sh
