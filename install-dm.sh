# clone dm repository
git clone https://github.com/cynkra/dm

# change project directory
cd dm

# Set up rig
curl -Ls https://github.com/r-lib/rig/releases/download/latest/rig-linux-latest.tar.gz | sudo tar xz -C /usr/local
# Set up R
rig install
rig system add-pak
rig system make-links
rig system setup-user-lib

# Deps
sudo apt update
sudo apt install -y ccache cmake r-base libharfbuzz-dev libfribidi-dev

## Set up ccache
ln -s /usr/lib/ccache/* ~/bin/

## Work around glitch with non-systemd systems
ln -s $(which true) ~/bin/timedatectl

## Define PATH
# FIXME: Why is this necessary? This doesn't work in Radian.
echo 'export PATH='${HOME}'/bin:${PATH}' >> ~/.bashrc

# Set up Makevars
mkdir -p ~/.R
echo -e "MAKEFLAGS = -j8\nCXXFLAGS = -O0 -g" > ~/.R/Makevars

# Install R packages
echo 'options(repos = "https://packagemanager.rstudio.com/all/__linux__/'$(cat /etc/lsb-release | sed  -n '/DISTRIB_CODENAME=/ {s///;p}')'/latest")' >> ~/.Rprofile

## Install devtools and R dependencies
R -q -e 'pak::pak(); pak::pak(c("devtools", "languageserver", "styler"));'

# Install radian
sudo pip install radian

## Install Postgres server
sudo apt-get install -y postgresql

## Start Postgres server
sudo service postgresql start

## Configure test database
sudo sudo -u postgres createuser -s $USER
createdb ${USER}

## Install MariaDB server
sudo apt-get install -y mariadb-server mariadb-client

## Start MariaDB server
sudo service mysql start

## Configure test database
#sudo mysql -e "CREATE DATABASE IF NOT EXISTS test; ALTER DATABASE test CHARACTER SET 'utf8'; FLUSH PRIVILEGES;"
