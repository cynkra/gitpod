slug=$1

repo_name=${1##*/}

# Folder name for project
project=${2:-$repo_name}

# Clone repository
if ! [ -d "$project" ]; then
  git clone ${4:-https://github.com/}$1 $project
fi

# Go to the project directory
cd $project/$3

if [ -f "DESCRIPTION" ]; then
  ## Install devtools and R dependencies
  R -q -e 'pak::pak()'

  # Compile
  R -q -e 'pkgload::load_all()'
fi
