PKG_NAME="nvidia-390"
PKG_VERSION="390.157"
PKG_SHA256="162317a49aa5a521eb888ec12119bfe5a45cec4e8653efc575a2d04fb05bf581"
PKG_ARCH="x86_64"
PKG_LICENSE="LicenseRef-nonfree"
PKG_SITE="https://www.nvidia.com/en-us/drivers/unix/"
PKG_URL="http://us.download.nvidia.com/XFree86/Linux-x86_64/${PKG_VERSION}/NVIDIA-Linux-x86_64-${PKG_VERSION}-no-compat32.run"
PKG_DEPENDS_TARGET="toolchain util-macros libglvnd"
PKG_LONGDESC="NVIDIA 390.157 driver for ION / GeForce 9-400 series"
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
  mkdir -p ${INSTALL}/$(get_full_module_dir)/nvidia-390
    cp -P kernel/nvidia.ko ${INSTALL}/$(get_full_module_dir)/nvidia-390

  mkdir -p ${INSTALL}/usr/lib
    cp -P libEGL.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libEGL.so.390.157 ${INSTALL}/usr/lib/libEGL.so
    cp -P libEGL_nvidia.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libEGL_nvidia.so.390.157 ${INSTALL}/usr/lib/libEGL_nvidia.so
    cp -P libGL.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libGL.so.390.157 ${INSTALL}/usr/lib/libGL.so
    cp -P libGLESv1_CM_nvidia.so.390.157 ${INSTALL}/usr/lib/
    cp -P libGLESv2_nvidia.so.390.157 ${INSTALL}/usr/lib/
    cp -P libGLX_nvidia.so.390.157 ${INSTALL}/usr/lib/
    cp -P libGLdispatch.so.0 ${INSTALL}/usr/lib/
    cp -P libOpenGL.so.0 ${INSTALL}/usr/lib/
    cp -P libglx.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libglx.so.390.157 ${INSTALL}/usr/lib/libGLX.so
    cp -P libnvcuvid.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libnvcuvid.so.390.157 ${INSTALL}/usr/lib/libnvcuvid.so
    cp -P libnvidia-cfg.so.390.157 ${INSTALL}/usr/lib/
    cp -P libnvidia-compiler.so.390.157 ${INSTALL}/usr/lib/
    cp -P libnvidia-egl-wayland.so.1.0.2 ${INSTALL}/usr/lib/
    ln -sf libnvidia-egl-wayland.so.1.0.2 ${INSTALL}/usr/lib/libnvidia-egl-wayland.so.1
    ln -sf libnvidia-egl-wayland.so.1 ${INSTALL}/usr/lib/libnvidia-egl-wayland.so
    cp -P libnvidia-eglcore.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libnvidia-eglcore.so.390.157 ${INSTALL}/usr/lib/libnvidia-eglcore.so
    cp -P libnvidia-encode.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libnvidia-encode.so.390.157 ${INSTALL}/usr/lib/libnvidia-encode.so
    cp -P libnvidia-fatbinaryloader.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libnvidia-fatbinaryloader.so.390.157 ${INSTALL}/usr/lib/libnvidia-fatbinaryloader.so
    cp -P libnvidia-fbc.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libnvidia-fbc.so.390.157 ${INSTALL}/usr/lib/libnvidia-fbc.so
    cp -P libnvidia-glcore.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libnvidia-glcore.so.390.157 ${INSTALL}/usr/lib/libnvidia-glcore.so
    cp -P libnvidia-glsi.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libnvidia-glsi.so.390.157 ${INSTALL}/usr/lib/libnvidia-glsi.so
    cp -P libnvidia-gtk2.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libnvidia-gtk2.so.390.157 ${INSTALL}/usr/lib/libnvidia-gtk2.so
    cp -P libnvidia-gtk3.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libnvidia-gtk3.so.390.157 ${INSTALL}/usr/lib/libnvidia-gtk3.so
    cp -P libnvidia-ifr.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libnvidia-ifr.so.390.157 ${INSTALL}/usr/lib/libnvidia-ifr.so
    cp -P libnvidia-ml.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libnvidia-ml.so.390.157 ${INSTALL}/usr/lib/libnvidia-ml.so
    cp -P libnvidia-opencl.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libnvidia-opencl.so.390.157 ${INSTALL}/usr/lib/libnvidia-opencl.so
    cp -P libnvidia-ptxjitcompiler.so.390.157 ${INSTALL}/usr/lib/
    cp -P libnvidia-tls.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libnvidia-tls.so.390.157 ${INSTALL}/usr/lib/libnvidia-tls.so
    cp -P libnvidia-wfb.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libnvidia-wfb.so.390.157 ${INSTALL}/usr/lib/libnvidia-wfb.so
    cp -P libvdpau_nvidia.so.390.157 ${INSTALL}/usr/lib/
    ln -sf libvdpau_nvidia.so.390.157 ${INSTALL}/usr/lib/libvdpau_nvidia.so

  mkdir -p ${INSTALL}/usr/lib/modules
    cp -P libGL.so.390.157 ${INSTALL}/usr/lib/modules/
    cp -P libglx.so.390.157 ${INSTALL}/usr/lib/modules/
    cp -P libnvidia-tls.so.390.157 ${INSTALL}/usr/lib/modules/

  mkdir -p ${INSTALL}/usr/share/nvidia-390
    cp -P nvidia_drv.so ${INSTALL}/usr/lib/xorg/modules/drivers/
}