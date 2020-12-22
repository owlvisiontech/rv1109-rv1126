#!/bin/bash

# Target chip
export RK_CHIP=RV1126
# Target arch
export RK_ARCH=arm
# Uboot defconfig
#export RK_UBOOT_DEFCONFIG=rv1126
export RK_UBOOT_DEFCONFIG=rv1126-ab
# Uboot image format type: fit(flattened image tree)
export RK_UBOOT_FORMAT_TYPE=fit
#export RK_SPL_DEFCONFIG=rv1126
export RK_SPL_DEFCONFIG=rv1126-ab
# Kernel defconfig
export RK_KERNEL_DEFCONFIG=rv1126_defconfig
# Kernel defconfig fragment
export RK_KERNEL_DEFCONFIG_FRAGMENT="rv1126-uvc-spi-nand.config"
# Kernel dts
export RK_KERNEL_DTS=rv11xx-owl-38ipc-v10-imx415
# boot image type
export RK_BOOT_IMG=zboot.img
# kernel image path
export RK_KERNEL_IMG=kernel/arch/arm/boot/zImage
# parameter for GPT table
#export RK_PARAMETER=parameter-fit-128M.txt
export RK_PARAMETER=parameter-fit-128M-ab.txt
# Buildroot config
export RK_CFG_BUILDROOT=rockchip_rv11xx_owl_uvcc_spi_nand
# Recovery config
export RK_CFG_RECOVERY=
# ramboot config
export RK_CFG_RAMBOOT=
# Pcba config
export RK_CFG_PCBA=
# Build jobs
export RK_JOBS=12
# target chip
export RK_TARGET_PRODUCT=rv1126_rv1109
# Set rootfs type, including ext2 ext4 squashfs ubi
export RK_ROOTFS_TYPE=ubi
# rootfs image path
export RK_ROOTFS_IMG=rockdev/rootfs.${RK_ROOTFS_TYPE}
# Set ramboot image type
export RK_RAMBOOT_TYPE=
# Set oem partition type, including ext2 squashfs
export RK_OEM_FS_TYPE=
# Set userdata partition type, including ext2, fat
export RK_USERDATA_FS_TYPE=ubi
#OEM config
export RK_OEM_DIR=
#userdata config, if not define this, system will format by RK_USERDATA_FS_TYPE
export RK_USERDATA_DIR=userdata_empty
#
# RK_UBI_PAGE_SIZE and RK_UBI_BLOCK_SIZE MUST be defined if meet One of the following conditions:
#
# 1. define RK_OEM_DIR and undefine RK_OEM_BUILDIN_BUILDROOT
# 2. define RK_USERDATA_DIR
#
# Set ubifs page size, 2048(2KB) or 4096(4KB)
export RK_UBI_PAGE_SIZE=2048
#
# Set ubifs block size, 0x20000(128KB) or 0x40000(256KB)
export RK_UBI_BLOCK_SIZE=0x20000
#
# Set userdata partition size (byte) if define RK_USERDATA_DIR
export RK_USERDATA_PARTITION_SIZE=0x680000
#
# Set oem partition size (byte) if undefine RK_OEM_BUILDIN_BUILDROOT
# export RK_OEM_PARTITION_SIZE=0x6400000
#
#misc image
export RK_MISC=
#choose enable distro module
export RK_DISTRO_MODULE=
# Define pre-build script for this board
export RK_BOARD_PRE_BUILD_SCRIPT=app-build.sh
# Define package-file for update.img
export RK_PACKAGE_FILE=rv1126-package-file-spi-nand
#choose enable Linux A/B
export RK_LINUX_AB_ENABLE=true
