#!/bin/bash
#############################################################################
# Wipe for AsusWRT
#
# This script downloads and compiles all packages needed for adding 
# secure file wiping capability of magnetic media to Asus ARM routers.
#
# Before running this script, you must first compile your router firmware so
# that it generates the AsusWRT libraries.  Do not "make clean" as this will
# remove the libraries needed by this script.
#############################################################################
PATH_CMD="$(readlink -f $0)"

set -e
set -x

#REBUILD_ALL=1
PACKAGE_ROOT="$HOME/asuswrt-merlin-addon/asuswrt"
SRC="$PACKAGE_ROOT/src"
ASUSWRT_MERLIN="$HOME/asuswrt-merlin"
TOP="$ASUSWRT_MERLIN/release/src/router"
BRCMARM_TOOLCHAIN="$ASUSWRT_MERLIN/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3"
SYSROOT="$BRCMARM_TOOLCHAIN/arm-brcm-linux-uclibcgnueabi/sysroot"
echo $PATH | grep -qF /opt/brcm-arm || export PATH=$PATH:/opt/brcm-arm/bin:/opt/brcm-arm/arm-brcm-linux-uclibcgnueabi/bin:/opt/brcm/hndtools-mipsel-linux/bin:/opt/brcm/hndtools-mipsel-uclibc/bin
[ ! -d /opt ] && sudo mkdir -p /opt
[ ! -h /opt/brcm ] && sudo ln -sf $HOME/asuswrt-merlin/tools/brcm /opt/brcm
[ ! -h /opt/brcm-arm ] && sudo ln -sf $HOME/asuswrt-merlin/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3 /opt/brcm-arm
[ ! -d /projects/hnd/tools/linux ] && sudo mkdir -p /projects/hnd/tools/linux
[ ! -h /projects/hnd/tools/linux/hndtools-arm-linux-2.6.36-uclibc-4.5.3 ] && sudo ln -sf /opt/brcm-arm /projects/hnd/tools/linux/hndtools-arm-linux-2.6.36-uclibc-4.5.3
#sudo apt-get install makedepends libltdl-dev automake1.11
#MAKE="make -j`nproc`"
MAKE="make -j1"

######## ####################################################################
# WIPE # ####################################################################
######## ####################################################################

DL="wipe-2.3.1.tar.bz2"
URL="https://downloads.sourceforge.net/project/wipe/wipe/2.3.1/$DL"
mkdir -p $SRC/wipe && cd $SRC/wipe
FOLDER="${DL%.tar.bz2*}"
[ "$REBUILD_ALL" == "1" ] && rm -rf "$FOLDER"
if [ ! -f "$FOLDER/__package_installed" ]; then
[ ! -f "$DL" ] && wget $URL
[ ! -d "$FOLDER" ] && tar xjvf $DL
cd $FOLDER

PKG_CONFIG_PATH="$PACKAGE_ROOT/lib/pkgconfig" \
OPTS="-ffunction-sections -fdata-sections -O3 -pipe -march=armv7-a -mtune=cortex-a9 -fno-caller-saves -mfloat-abi=soft -Wall -fPIC -std=gnu99 -I$PACKAGE_ROOT/include  -I$PACKAGE_ROOT/usr/include" \
CC="arm-brcm-linux-uclibcgnueabi-gcc" \
STRIP="arm-brcm-linux-uclibcgnueabi-strip" \
CFLAGS="$OPTS" CXXFLAGS="$OPTS" CPPFLAGS="$OPTS" \
LDFLAGS="-ffunction-sections -fdata-sections -Wl,--gc-sections  -L$PACKAGE_ROOT/lib" \
./configure \
--host=arm-linux \
--build=x86_64-linux \
--prefix=$PACKAGE_ROOT \
--mandir=$PACKAGE_ROOT/share/man \
--enable-static \
--enable-shared

$MAKE

#################
# make install
# (install everything as non-root user)
BIN="wipe"
prefix="${PACKAGE_ROOT}"
exec_prefix="${PACKAGE_ROOT}"
bindir="${exec_prefix}/bin"
sbindir="${exec_prefix}/sbin"
datadir="${prefix}/share"
mandir="${prefix}/share/man"
srcdir="."
BIN_OUT="$srcdir/$BIN"
INSTALL="install"
INSTALL_BIN="install -m 0755"
$INSTALL_BIN -d $bindir
$INSTALL_BIN -s --strip-program=arm-brcm-linux-uclibcgnueabi-strip $BIN_OUT $bindir
$INSTALL -d $mandir/man1
$INSTALL -m 0644 wipe.1 $mandir/man1/
rm -rf $datadir/doc/wipe*
$INSTALL -d $datadir/doc/wipe
for file in $DOCS; do
	$INSTALL -m 0644 $file $datadir/doc/wipe/
done
#################

touch __package_installed
fi
