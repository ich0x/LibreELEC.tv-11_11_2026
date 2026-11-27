PKG_NAME="xlibre-video-amdgpu"
PKG_VERSION="25.0.0"
PKG_SHA256="SKIP"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/X11Libre/xf86-video-amdgpu"
PKG_URL="https://github.com"
PKG_DEPENDS_TARGET="toolchain libdrm mesa xlibre-server"
PKG_LONGDESC="XLibre AMDGPU X11 video driver"

pre_configure_target() {
  export PKG_CONFIG_PATH="${SYSROOT_PREFIX}/usr/xlibre/lib/pkgconfig:${PKG_CONFIG_PATH}"
  export CFLAGS="${CFLAGS} -I${SYSROOT_PREFIX}/usr/xlibre/include/xorg"
  cd ${PKG_BUILD}
  autoreconf -vif
}

PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr/xlibre \
                           --enable-glamor \
                           --with-xorg-conf-dir=/usr/xlibre/share/X11/xorg.conf.d"
