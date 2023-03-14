# Error handling
set -eux pipefail

# https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver16&tabs=alpine18-install%2Cubuntu17-install%2Cdebian8-install%2Credhat7-13-install%2Crhel7-offline#17
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list

sudo apt-get update -y
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools unixodbc-dev

sudo ln -s /opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.10.so.* /opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.so

sudo cp dm/.github/odbc/odbc*.ini /etc/

# Spin up Docker
docker-compose up -d

# Create database
/opt/mssql-tools/bin/sqlcmd -U SA -P 'YourStrong!Passw0rd' -Q 'DROP DATABASE test; CREATE DATABASE test;'
