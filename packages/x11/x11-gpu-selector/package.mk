PKG_NAME="x11-gpu-selector"
PKG_VERSION="1.0"
PKG_LICENSE="GPL"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain xorg-server xlibre-server xlibre-input-libinput xlibre-video-amdgpu xlibre-video-intel xlibre-video-nouveau"
PKG_LONGDESC="Runtime GPU selector for XLibre and Xorg"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cat << 'EOF' > ${INSTALL}/usr/bin/x11-select.sh
#!/bin/sh
OVERRIDE_FILE="/storage/.config/x11-server.conf"
SELECTED="xorg"

if grep -q "x11=xlibre" /proc/cmdline; then
  SELECTED="xlibre"
elif grep -q "x11=xorg" /proc/cmdline; then
  SELECTED="xorg"
elif [ -f "$OVERRIDE_FILE" ]; then
  . "$OVERRIDE_FILE"
  [ "$X11_SERVER" = "xlibre" ] && SELECTED="xlibre"
else
  for dev in /sys/bus/pci/devices/*; do
    CLASS=$(cat "$dev/class" 2>/dev/null)
    case "$CLASS" in
      0x0300*)
        VENDOR=$(cat "$dev/vendor" 2>/dev/null)
        case "$VENDOR" in
          0x10de) SELECTED="xorg" ;;
          0x1002|0x8086) SELECTED="xlibre" ;;
        esac
        ;;
    esac
  done
fi

mkdir -p /run/x11
if [ "$SELECTED" = "xlibre" ] && [ -x /usr/xlibre/bin/Xorg ]; then
  ln -sf /usr/xlibre/bin/Xorg /run/x11/Xorg
  echo "MODULE_PATH=/usr/xlibre/lib/xorg/modules" > /run/x11/env
else
  ln -sf /usr/bin/Xorg /run/x11/Xorg
  echo "MODULE_PATH=/usr/lib/xorg/modules" > /run/x11/env
fi
EOF
  chmod +x ${INSTALL}/usr/bin/x11-select.sh

  mkdir -p ${INSTALL}/usr/lib/systemd/system
  cat << 'EOF' > ${INSTALL}/usr/lib/systemd/system/x11-select.service
[Unit]
Description=Select X11 Server (XLibre vs Xorg) for GPU
DefaultDependencies=no
Before=xorg.service
After=systemd-udev-settle.service local-fs.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/x11-select.sh

[Install]
WantedBy=xorg.service
EOF

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
