# Error handling
set -eux pipefail

# Set up rig
curl -Ls https://github.com/r-lib/rig/releases/download/latest/rig-linux-latest.tar.gz | sudo tar xz -C /usr/local
# Set up R
rig install
rig system add-pak
rig system make-links
rig system setup-user-lib

# Create bin directory
mkdir -p /home/gitpod/bin

# Deps
sudo apt update
sudo apt upgrade -y
sudo apt install -y ccache cmake

## Set up ccache
ln -fs /usr/lib/ccache/* ~/bin/

## Work around glitch with non-systemd systems
ln -fs $(which true) ~/bin/timedatectl

## Define PATH
# FIXME: Why is this necessary? This doesn't work in Radian.
echo 'export PATH='${HOME}'/bin:${PATH}' >> ~/.bashrc

# Set up Makevars
mkdir -p ~/.R
echo -e "MAKEFLAGS = -j8\nCXXFLAGS = -O0 -g" > ~/.R/Makevars

# Install R packages
echo 'options(repos = "https://packagemanager.rstudio.com/all/__linux__/'$(cat /etc/lsb-release | sed  -n '/DISTRIB_CODENAME=/ {s///;p}')'/latest")' >> ~/.Rprofile

# Install radian
sudo pip install radian