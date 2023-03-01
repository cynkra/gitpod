# Error handling
set -eux pipefail

# Configure duckdb
echo DUCKDB_R_DEBUG=1 >> ~/.Renviron

# Folder with base scripts
LIB_FOLDER=$(dirname $0)/lib

# Run base script
sh $LIB_FOLDER/base.sh

PROJECT=duckdb 

# Clone DuckDB repository
if ! [ -d "$PROJECT" ]; then
    git clone https://github.com/duckdb/duckdb $PROJECT
fi

# Go to the project directory
cd $PROJECT/tools/rpkg

# R dependencies
R -q -e 'pak::pak()'

# Compile
R -q -e 'pkgload::load_all()'
