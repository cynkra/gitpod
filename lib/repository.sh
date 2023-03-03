# Folder name for project
PROJECT=$2

# Clone repository
if ! [ -d "$PROJECT" ]; then
    git clone $1 $PROJECT
fi

# Go to the project directory
cd $PROJECT/$3

## Install devtools and R dependencies
R -q -e 'pak::pak()'

# Compile
R -q -e 'pkgload::load_all()'
