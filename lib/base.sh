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
sudo apt upgrade -y
sudo apt install -y ccache cmake silversearcher-ag

curl -L -o /tmp/git-delta.deb https://github.com/dandavison/delta/releases/download/0.11.3/git-delta_0.11.3_amd64.deb
sudo dpkg -i /tmp/git-delta.deb
rm /tmp/git-delta.deb

# Set up rig
curl -Ls https://github.com/r-lib/rig/releases/download/latest/rig-linux-latest.tar.gz | sudo tar xz -C /usr/local
# Set up R
rig install
rig system add-pak --pak-version devel
rig system make-links
rig system setup-user-lib

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

# Install R packages
echo 'options(repos = "https://packagemanager.rstudio.com/all/__linux__/'$(cat /etc/lsb-release | sed  -n '/DISTRIB_CODENAME=/ {s///;p}')'/latest")' >> ~/.Rprofile.gitpod
R -q -e 'pak::pak(c("devtools", "languageserver", "styler", "reprex", "cpp11", "decor"))'

# Install radian
sudo pip install radian

# Indicate completion
if [ ${USER} = "gitpod" ]; then
  mkdir -p ~/.gitpod
  touch ~/.gitpod/base
fi
