PKG_NAME="nvidia-340"
PKG_VERSION="340.108"
PKG_SHA256="995d44fef587ff5284497a47a95d71adbee0c13020d615e940ac928f180f5b77"
PKG_ARCH="x86_64"
PKG_LICENSE="LicenseRef-nonfree"
PKG_SITE="https://www.nvidia.com/en-us/drivers/unix/"
PKG_URL="http://us.download.nvidia.com/XFree86/Linux-x86_64/${PKG_VERSION}/NVIDIA-Linux-x86_64-${PKG_VERSION}-no-compat32.run"
PKG_DEPENDS_TARGET="toolchain util-macros libglvnd"
PKG_LONGDESC="NVIDIA 340.108 driver for ION / GeForce 8-9 series"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

PKG_BUILD_SUBDIR=""

unpack() {
  [ -d ${PKG_BUILD} ] && rm -rf ${PKG_BUILD}
  sh ${SOURCES}/${PKG_NAME}/${PKG_SOURCE_NAME} --extract-only --target ${PKG_BUILD}
}

make_target() {
  unset LDFLAGS
  cd ${PKG_BUILD}/kernel
    make module CC=${CC} LD=${LD} SYSSRC=$(kernel_path) SYSOUT=$(kernel_path)
    ${STRIP} --strip-debug nvidia.ko
  cd ..
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/nvidia-340
    cp -P kernel/nvidia.ko ${INSTALL}/$(get_full_module_dir)/nvidia-340

  mkdir -p ${INSTALL}/usr/lib
    cp -P libEGL.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libEGL.so.340.108 ${INSTALL}/usr/lib/libEGL.so
    cp -P libGL.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libGL.so.340.108 ${INSTALL}/usr/lib/libGL.so
    cp -P libGLESv1_CM.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libGLESv1_CM.so.340.108 ${INSTALL}/usr/lib/libGLESv1_CM.so
    cp -P libGLESv2.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libGLESv2.so.340.108 ${INSTALL}/usr/lib/libGLESv2.so
    cp -P libglx.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libglx.so.340.108 ${INSTALL}/usr/lib/libGLX.so
    cp -P libnvcuvid.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libnvcuvid.so.340.108 ${INSTALL}/usr/lib/libnvcuvid.so
    cp -P libnvidia-cfg.so.340.108 ${INSTALL}/usr/lib/
    cp -P libnvidia-compiler.so.340.108 ${INSTALL}/usr/lib/
    cp -P libnvidia-eglcore.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libnvidia-eglcore.so.340.108 ${INSTALL}/usr/lib/libnvidia-eglcore.so
    cp -P libnvidia-encode.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libnvidia-encode.so.340.108 ${INSTALL}/usr/lib/libnvidia-encode.so
    cp -P libnvidia-fbc.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libnvidia-fbc.so.340.108 ${INSTALL}/usr/lib/libnvidia-fbc.so
    cp -P libnvidia-glcore.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libnvidia-glcore.so.340.108 ${INSTALL}/usr/lib/libnvidia-glcore.so
    cp -P libnvidia-glsi.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libnvidia-glsi.so.340.108 ${INSTALL}/usr/lib/libnvidia-glsi.so
    cp -P libnvidia-ifr.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libnvidia-ifr.so.340.108 ${INSTALL}/usr/lib/libnvidia-ifr.so
    cp -P libnvidia-ml.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libnvidia-ml.so.340.108 ${INSTALL}/usr/lib/libnvidia-ml.so
    cp -P libnvidia-opencl.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libnvidia-opencl.so.340.108 ${INSTALL}/usr/lib/libnvidia-opencl.so
    cp -P libnvidia-tls.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libnvidia-tls.so.340.108 ${INSTALL}/usr/lib/libnvidia-tls.so
    cp -P libnvidia-wfb.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libnvidia-wfb.so.340.108 ${INSTALL}/usr/lib/libnvidia-wfb.so
    cp -P libvdpau_nvidia.so.340.108 ${INSTALL}/usr/lib/
    ln -sf libvdpau_nvidia.so.340.108 ${INSTALL}/usr/lib/libvdpau_nvidia.so

  mkdir -p ${INSTALL}/usr/lib/modules
    cp -P libGL.so.340.108 ${INSTALL}/usr/lib/modules/
    cp -P libglx.so.340.108 ${INSTALL}/usr/lib/modules/
    cp -P libnvidia-tls.so.340.108 ${INSTALL}/usr/lib/modules/

  mkdir -p ${INSTALL}/usr/share/nvidia-340
    cp -P nvidia_drv.so ${INSTALL}/usr/lib/xorg/modules/drivers/
}