pkg_name=wget
pkg_derivation=chef
pkg_version=1.16.3
pkg_license=('gplv3+')
pkg_maintainer="The Bldr Maintainers <bldr@chef.io>"
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=67f7b7b0f5c14db633e3b18f53172786c001e153d545cfc85d82759c5c2ffb37
pkg_deps=(chef/glibc chef/libidn chef/zlib chef/openssl chef/cacerts)
pkg_build_deps=(chef/gcc chef/coreutils chef/sed chef/bison chef/flex chef/grep chef/bash chef/gawk chef/libtool chef/diffutils chef/findutils chef/xz chef/gettext chef/gzip chef/make chef/patch chef/texinfo chef/util-linux chef/perl)
pkg_binary_path=(bin)
pkg_gpg_key=3853DA6B

do_prepare() {
  # Purge the codebase (mostly tests & build Perl scripts) of the hardcoded
  # reliance on `/usr/bin/env`.
  grep -lr '/usr/bin/env' . | while read f; do
    sed -e "s,/usr/bin/env,$(pkg_path_for coreutils)/bin/env,g" -i "$f"
  done
}

do_build() {
  ./configure \
    --prefix=$pkg_prefix \
    --with-ssl=openssl \
    --with-libssl-prefix=$(pkg_path_for openssl) \
    --without-libuuid \
    --without-pcre
  make
}

do_install() {
  do_default_install

  cat <<EOF >> $pkg_path/etc/wgetrc

# Default root CA certs location
ca_certificate=$(pkg_path_for cacerts)/ssl/certs/cacert.pem
EOF
}