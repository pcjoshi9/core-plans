pkg_name=gawk
pkg_origin=chef
pkg_version=4.1.3
pkg_maintainer="The Bldr Maintainers <bldr@chef.io>"
pkg_license=('gplv3+')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=524effa5b9ecd4ed940f2581c5d3c1df4e4bd7e6f768aa033c1916f47dfc6e29
pkg_deps=(chef/glibc chef/mpfr)
pkg_build_deps=(chef/coreutils chef/diffutils chef/patch chef/make chef/gcc chef/sed)
pkg_binary_path=(bin)
pkg_gpg_key=3853DA6B
pkg_interpreters=(bin/awk bin/gawk)

do_check() {
  make check
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(chef/gcc chef/coreutils chef/sed)
fi
