#!/bin/sh
# Selects XLibre or upstream Xorg based on user override or GPU hardware

OVERRIDE_FILE="/storage/.config/x11-server.conf"
SELECTED="xorg"

# 1. Check kernel command line override (e.g., x11=xlibre or x11=xorg)
if grep -q "x11=xlibre" /proc/cmdline; then
  SELECTED="xlibre"
elif grep -q "x11=xorg" /proc/cmdline; then
  SELECTED="xorg"
# 2. Check persistent user config override
elif [ -f "$OVERRIDE_FILE" ]; then
  . "$OVERRIDE_FILE"
  [ "$X11_SERVER" = "xlibre" ] && SELECTED="xlibre"
# 3. Auto-detect GPU vendor via sysfs PCI IDs
else
  for dev in /sys/bus/pci/devices/*; do
    CLASS=$(cat "$dev/class" 2>/dev/null)
    # 0x030000 = VGA compatible controller
    case "$CLASS" in
      0x0300*)
        VENDOR=$(cat "$dev/vendor" 2>/dev/null)
        case "$VENDOR" in
          # 0x10de = NVIDIA (proprietary legacy drivers often prefer upstream Xorg ABI)
          0x10de) SELECTED="xorg" ;;
          # 0x1002 = AMD, 0x8086 = Intel (benefit from XLibre TearFree & modesetting)
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
