# Error handling
set -eux pipefail

# Run base script
sh $(pwd)/lib/base.sh

PROJECT=igraph 

# Clone RMariaDB repository
if ! [ -d "$PROJECT" ]; then
    git clone https://github.com/igraph/rigraph $PROJECT
fi

# Go to the project directory
cd $PROJECT

## Install devtools and R dependencies
R -q -e 'pak::pak(); pak::pak(c("devtools", "languageserver", "styler"));'
