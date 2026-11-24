PKG_NAME="x11-gpu-selector"
PKG_VERSION="1.0"
PKG_LICENSE="GPL"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain xorg-server xlibre-server xlibre-input-libinput xlibre-video-amdgpu xlibre-video-intel xlibre-video-nouveau"
PKG_LONGDESC="Runtime GPU selector for XLibre and Xorg"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_DIR}/sources/x11-select.sh ${INSTALL}/usr/bin/
  chmod +x ${INSTALL}/usr/bin/x11-select.sh

  mkdir -p ${INSTALL}/usr/lib/systemd/system
  cp ${PKG_DIR}/sources/x11-select.service ${INSTALL}/usr/lib/systemd/system/

  mkdir -p ${INSTALL}/usr/lib/systemd/system/xorg.service.d
  cat << 'EOF' > ${INSTALL}/usr/lib/systemd/system/xorg.service.d/10-x11-selector.conf
[Unit]
Wants=x11-select.service
After=x11-select.service

[Service]
EnvironmentFile=/run/x11/env
ExecStart=
ExecStart=/run/x11/Xorg :0 -nolisten tcp vt01 -s 0 -dpms -modulepath ${MODULE_PATH}
EOF
}

post_install() {
  enable_service x11-select.service
}
