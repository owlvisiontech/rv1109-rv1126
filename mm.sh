#  Copyright (C)
#  2020 - www.owlvision-tech.com
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either version 2
#  of the License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

#!/bin/bash

RK_BOARD_CONFIG=device/rockchip/.BoardConfig.mk
BUILD_RET=0
START_TIME=$(date +%s)

RK_CFG_BUILDROOT=rockchip_rv11xx_owl_fgnodis
# RK_CFG_BUILDROOT=rockchip_rv1126_rv1109_spi_nand

if [ ! -f $RK_BOARD_CONFIG ]; then
    echo "Please execut ./build.sh device/rockchip/rv1126_rv1109/BoardConfig-xxxx first"
fi

RK_CFG_BUILDROOT_LINE=`cat $RK_BOARD_CONFIG|grep RK_CFG_BUILDROOT`
RK_CFG_BUILDROOT_VALUE=${RK_CFG_BUILDROOT_LINE#*=}

echo $RK_CFG_BUILDROOT_VALUE

if [ -n $RK_CFG_BUILDROOT_VALUE ]; then
    RK_CFG_BUILDROOT=$RK_CFG_BUILDROOT_VALUE
fi

echo ""
echo "=============Building Info======================"
echo -e "\033[32m [OUTDIR]:output/$RK_CFG_BUILDROOT \033[0m"
echo -e "\033[32m [USRCMD]:$1 \033[0m"
echo "===================END=========================="
echo ""

cd buildroot

make O=output/$RK_CFG_BUILDROOT $1 $2

END_TIME=$(date +%s)
COST_TIME=$[ $END_TIME-$START_TIME ]

echo "=============Building Sumary===================="
if [ $? -eq 0  ]; then
    echo -e "\033[32m Build finished! \033[0m"
    BUILD_RET=1
else
    echo -e "\033[31m Build failed! \033[0m"
    BUILD_RET=0
fi
echo " Takes $(($COST_TIME/60))min $(($COST_TIME%60))s"
echo "===================END=========================="

cd ..


