# Error handling
set -eux pipefail

# Folder with base scripts
LIB_FOLDER=$(dirname $0)/lib

# Run base script
sh $LIB_FOLDER/base.sh

# Clone rdb repository
sh $LIB_FOLDER/repository.sh krlmlr/rdb
