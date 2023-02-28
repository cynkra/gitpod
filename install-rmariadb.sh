# Error handling
set -eux pipefail

# Run base script
sh $(pwd)/lib/base.sh

PROJECT=RMariaDB 

# Clone RMariaDB repository
if ! [ -d "$PROJECT" ]; then
    git clone https://github.com/r-dbi/RMariaDB $PROJECT
fi

# Go to the project directory
cd $PROJECT

## Install devtools and R dependencies
R -q -e 'pak::pak(); pak::pak(c("devtools", "languageserver", "styler"));'

# Install MariaDB script
sh $(pwd)/lib/mariadb.sh