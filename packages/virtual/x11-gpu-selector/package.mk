PKG_NAME="x11-gpu-selector"
PKG_ARCH="arm"
PKG_LICENSE="GPLv3"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="xorg-launch-helper xlibre-server"
PKG_DEPENDS_HOST=""
PKG_LONGDESC="Virtual package that adds xorg-launch-helper and xlibre-server to the image, enabling GPU selector at boot."
PKG_IS_KERNEL_PKG="yes"

makeinstall_target() {
  mkdir -p ${INSTALL}/etc/profile.d/
  cat <<'EOF' > ${INSTALL}/etc/profile.d/x11-gpu-selector.sh
export XORG_SERVER=/usr/xlibre/bin/Xorg
EOF
  chmod +x ${INSTALL}/etc/profile.d/x11-gpu-selector.sh
}