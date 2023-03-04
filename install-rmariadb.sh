# Error handling
set -eux pipefail

# Folder with base scripts
LIB_FOLDER=$(dirname $0)/lib

# Run base script
sh $LIB_FOLDER/base.sh

# Install MariaDB script
sh $LIB_FOLDER/mariadb.sh

# Clone RMariaDB repository
sh $LIB_FOLDER/repository.sh https://github.com/r-dbi/RMariaDB RMariaDB
