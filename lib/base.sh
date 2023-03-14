# Error handling
set -eux pipefail

# Fast path
if [ ${USER} = "gitpod" -a -f ~/.gitpod/base ]; then
  echo "$(basename $0): Already executed"
  exit 0
fi

# scriptlets
if ! [ -f ~/.gitconfig.gitpod ]; then
  mv ~/.gitconfig ~/.gitconfig.gitpod
fi
curl -s https://raw.githubusercontent.com/krlmlr/scriptlets/master/bootstrap | sh

# Deps
sudo apt update
sudo apt install -y ccache cmake silversearcher-ag

curl -L -o /tmp/git-delta.deb https://github.com/dandavison/delta/releases/download/0.11.3/git-delta_0.11.3_amd64.deb
sudo dpkg -i /tmp/git-delta.deb
rm /tmp/git-delta.deb

# Set up rig
curl -Ls https://github.com/r-lib/rig/releases/download/latest/rig-linux-latest.tar.gz | sudo tar xz -C /usr/local

# Create bin directory
mkdir -p /home/gitpod/bin

## Set up ccache
ln -fs /usr/lib/ccache/* ~/bin/

## Work around glitch with non-systemd systems
ln -fs $(which true) ~/bin/timedatectl

## Define PATH
# FIXME: Why is this necessary? This doesn't work in Radian.
echo 'export PATH='${HOME}'/bin:${PATH}' >> ~/.bashrc

# Set up Makevars
mkdir -p ~/.R
echo "MAKEFLAGS = -j4\nCXXFLAGS = -O0 -g" > ~/.R/Makevars

# Set up R library directory
rm -rf ~/R
mkdir -p /workspace/gitpod/R
ln -sf /workspace/gitpod/R ~/

# Set up .Rprofile
echo 'options(repos = "https://packagemanager.rstudio.com/all/__linux__/'$(cat /etc/lsb-release | sed  -n '/DISTRIB_CODENAME=/ {s///;p}')'/latest")' >> ~/.Rprofile.gitpod

# Install R and packages
sh lib/r.sh

# Install radian
sudo pip install radian

# Indicate completion
if [ ${USER} = "gitpod" ]; then
  mkdir -p ~/.gitpod
  touch ~/.gitpod/base
fi
