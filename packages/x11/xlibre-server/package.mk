PKG_NAME="xlibre-server"
PKG_VERSION="25.0.0.16"
PKG_SHA256="SKIP"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/X11Libre/xserver"
PKG_URL="https://github.com"
PKG_DEPENDS_TARGET="toolchain pixman libepoxy libxkbfile libXfont2 libpciaccess libdrm mesa xorgproto"
PKG_LONGDESC="XLibre X11 display server installed to /usr/xlibre"

PKG_MESON_OPTS_TARGET="--prefix=/usr/xlibre \
                       -Dxorg=true \
                       -Dxwayland=false \
                       -Dxnest=false \
                       -Dxvfb=false \
                       -Dudev=true \
                       -Dsystemd_logind=true \
                       -Dsuid_wrapper=false \
                       -Dxcsecurity=true \
                       -Ddri2=true \
                       -Ddri3=true \
                       -Dglamor=true"
