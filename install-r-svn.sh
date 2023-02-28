# Error handling
set -eux

# Run base script
sh ./lib/base.sh

# clone r-svn repository
if ! [ -d r-svn ]; then
  git clone https://github.com/r-devel/r-svn
fi

cd r-svn

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y clang gcc wget locales git rsync gfortran xvfb autoconf pkg-config texinfo texlive-latex-extra texlive-fonts-recommended tk8.6-dev libcurl4-openssl-dev libblas-dev libbz2-dev libicu-dev libjpeg-dev liblapack-dev liblzma-dev libncurses5-dev libpcre2-dev libpng-dev libreadline-dev libxt-dev
sudo localedef -i en_US -f UTF-8 en_US.UTF-8

sed -i.bak 's|$(GIT) svn info|./.github/scripts/svn-info.sh|' Makefile.in
#./.github/scripts/wget-recommended.sh
./.github/scripts/svn-info.sh

./configure  --without-recommended-packages --enable-R-shlib --with-blas --with-lapack --disable-java --enable-strict-barrier

make -j4
