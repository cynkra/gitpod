version=${1:-release}

# Error handling
set -eux pipefail

# Set up R
rig install --pak-version devel ${version}
rig system setup-user-lib

R-${version} -q -e 'pak::pak(c("devtools", "languageserver", "styler", "reprex", "cpp11", "decor", "krlmlr/lazytest"))'
