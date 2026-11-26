PKG_NAME="nvidia-304"
PKG_VERSION="304.137"
PKG_SHA256="cd774539c322fca8328d382389a40f5aaece4c4bc562fac400f45af6ba7b78b1"
PKG_ARCH="x86_64"
PKG_LICENSE="LicenseRef-nonfree"
PKG_SITE="https://www.nvidia.com/en-us/drivers/unix/"
PKG_URL="http://us.download.nvidia.com/XFree86/Linux-x86_64/${PKG_VERSION}/NVIDIA-Linux-x86_64-${PKG_VERSION}-no-compat32.run"
PKG_DEPENDS_TARGET="toolchain util-macros libglvnd"
PKG_LONGDESC="NVIDIA 304.137 driver for ION / GeForce 600-700 series"
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
  mkdir -p ${INSTALL}/$(get_full_module_dir)/nvidia-304
    cp -P kernel/nvidia.ko ${INSTALL}/$(get_full_module_dir)/nvidia-304

  mkdir -p ${INSTALL}/usr/lib
    cp -P libGL.so.304.137 ${INSTALL}/usr/lib/
    ln -sf libGL.so.304.137 ${INSTALL}/usr/lib/libGL.so
    cp -P libOpenCL.so.1.0.0 ${INSTALL}/usr/lib/
    ln -sf libOpenCL.so.1.0.0 ${INSTALL}/usr/lib/libOpenCL.so.1
    ln -sf libOpenCL.so.1 ${INSTALL}/usr/lib/libOpenCL.so
    cp -P libXvMCNVIDIA.so.304.137 ${INSTALL}/usr/lib/
    cp -P libglx.so.304.137 ${INSTALL}/usr/lib/
    ln -sf libglx.so.304.137 ${INSTALL}/usr/lib/libGLX.so
    cp -P libnvcuvid.so.304.137 ${INSTALL}/usr/lib/
    ln -sf libnvcuvid.so.304.137 ${INSTALL}/usr/lib/libnvcuvid.so
    cp -P libnvidia-cfg.so.304.137 ${INSTALL}/usr/lib/
    cp -P libnvidia-compiler.so.304.137 ${INSTALL}/usr/lib/
    cp -P libnvidia-glcore.so.304.137 ${INSTALL}/usr/lib/
    ln -sf libnvidia-glcore.so.304.137 ${INSTALL}/usr/lib/libnvidia-glcore.so
    cp -P libnvidia-ml.so.304.137 ${INSTALL}/usr/lib/
    ln -sf libnvidia-ml.so.304.137 ${INSTALL}/usr/lib/libnvidia-ml.so
    cp -P libnvidia-opencl.so.304.137 ${INSTALL}/usr/lib/
    ln -sf libnvidia-opencl.so.304.137 ${INSTALL}/usr/lib/libnvidia-opencl.so
    cp -P libnvidia-tls.so.304.137 ${INSTALL}/usr/lib/
    ln -sf libnvidia-tls.so.304.137 ${INSTALL}/usr/lib/libnvidia-tls.so
    cp -P libnvidia-wfb.so.304.137 ${INSTALL}/usr/lib/
    ln -sf libnvidia-wfb.so.304.137 ${INSTALL}/usr/lib/libnvidia-wfb.so
    cp -P libvdpau_nvidia.so.304.137 ${INSTALL}/usr/lib/
    ln -sf libvdpau_nvidia.so.304.137 ${INSTALL}/usr/lib/libvdpau_nvidia.so

  mkdir -p ${INSTALL}/usr/lib/modules
    cp -P libGL.so.304.137 ${INSTALL}/usr/lib/modules/
    cp -P libglx.so.304.137 ${INSTALL}/usr/lib/modules/
    cp -P libnvidia-tls.so.304.137 ${INSTALL}/usr/lib/modules/

  mkdir -p ${INSTALL}/usr/share/nvidia-304
    cp -P nvidia_drv.so ${INSTALL}/usr/lib/xorg/modules/drivers/
}