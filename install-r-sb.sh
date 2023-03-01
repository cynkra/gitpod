# Error handling
set -eux

cd $(dirname $0)

# Run base script
sh ./lib/base.sh

# Download R 4.2.2
curl -L -o R-sb.tar.gz $(Rscript -e 'writeLines(rversions::r_release_tarball()$URL)')
mkdir -p R-sb
cd R-sb
tar xf ../R-sb.tar.gz --strip-components=1
rm ../R-sb.tar.gz

sudo apt-get install -y clang gcc wget locales git rsync gfortran xvfb autoconf pkg-config texinfo texlive-latex-extra texlive-fonts-recommended tk8.6-dev libcurl4-openssl-dev libblas-dev libbz2-dev libicu-dev libjpeg-dev liblapack-dev liblzma-dev libncurses5-dev libpcre2-dev libpng-dev libreadline-dev libxt-dev

./configure  --without-recommended-packages --enable-R-shlib --with-blas --with-lapack --disable-java --enable-strict-barrier

make -j4
