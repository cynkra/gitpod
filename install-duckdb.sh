# Error handling
set -eux pipefail

# Configure duckdb
echo DUCKDB_R_DEBUG=1 >> ~/.Renviron

# Folder with base scripts
LIB_FOLDER=$(dirname $0)/lib

# Run base script
sh $LIB_FOLDER/base.sh

# Clone DuckDB repository
sh $LIB_FOLDER/repository.sh duckdb/duckdb duckdb tools/rpkg
