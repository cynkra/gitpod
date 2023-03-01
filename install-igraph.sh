# Error handling
set -eux pipefail

# Folder with base scripts
LIB_FOLDER=$(dirname $0)/lib

# Run base script
sh $LIB_FOLDER/base.sh

PROJECT=igraph 

# Clone RMariaDB repository
if ! [ -d "$PROJECT" ]; then
    git clone https://github.com/igraph/rigraph $PROJECT
fi

# Go to the project directory
cd $PROJECT

## Install devtools and R dependencies
R -q -e 'pak::pak()'
