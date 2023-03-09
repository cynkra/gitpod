# Error handling
set -eux pipefail

# Folder with base scripts
LIB_FOLDER=$(dirname $0)/lib

# Run base script
sh $LIB_FOLDER/base.sh

# Install Postgres script
sh $LIB_FOLDER/postgres.sh

# Clone RPostgres repository
sh $LIB_FOLDER/repository.sh r-dbi/RPostgres
