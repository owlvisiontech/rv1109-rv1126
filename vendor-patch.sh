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

SDK_TOP_DIR=".."
BOARD_CONFIG_FILE="../device/rockchip/.BoardConfig.mk"

RK_FG_DTS="rv1109-evb-ddr3-v12-facial-gate"
OWL_FG_DTS="rv11xx-owl-ddr4-facial-gate"

FG_BOARD_CONFIG="$SDK_TOP_DIR/device/rockchip/rv1126_rv1109/BoardConfig-facial_gate.mk"

function show_notice()
{
    echo ""
    echo -e "\033[32m===============Attention Please======================\033[0m"
    echo "1) From http://www.owlvision-tech.com instead of rockchip."
    echo "2) You should backup your own change."
    echo "2) We will copy some files or overrid some files."
    echo "3) All the source files are in this directory"
    tree
    echo -e "\033[32m=====================================================\033[0m"
    echo ""
}

function check_dir()
{
    if [ ! -d "$1" ]; then
        echo -e "\033[31m Can't find $1 directory!\033[0m"
        echo -e "\033[31m You should copy these under you SDK!\033[0m"
        exit
    fi
}

function apply_change()
{
    echo -e "\033[32m=========>>>apply change\033[0m"
    rsync -avzt ./* --exclude="vendor-patch.sh" --exclude="LICENSE" --exclude="*.md" ../
    echo -e "\033[32m=========>>>apply change finished\033[0m"
}

function hot_fix()
{
    sed -i "s/ov2718->flip\ =\ 0;/ov2718->flip\ =\ OV2718_MIRROR\ |\ OV2718_FLIP;/g" \
        `grep "ov2718->flip\ =\ 0;" -rl $SDK_TOP_DIR/kernel/drivers/media/i2c/ov2718.c`
    sed -i "s/$RK_FG_DTS/$OWL_FG_DTS/g" \
        `grep "$RK_FG_DTS" -rl $FG_BOARD_CONFIG`
}

function confirm_change()
{
    read -r -p "Are You Sure do that? [Y/n] " input

    case $input in
        [yY][eE][sS]|[yY])
            apply_change
            hot_fix
            ;;

        [nN][oO]|[nN])
            echo "No"
            ;;

        *)
            echo "Invalid input..."
            exit 1
            ;;
    esac
}

function reconfig_after_apply_patch()
{
    if [ -f "$BOARD_CONFIG_FILE" ]; then
        rm $BOARD_CONFIG_FILE
    fi
}

show_notice
check_dir "$SDK_TOP_DIR/kernel"
check_dir "$SDK_TOP_DIR/u-boot"
check_dir "$SDK_TOP_DIR/device"
confirm_change
reconfig_after_apply_patch

