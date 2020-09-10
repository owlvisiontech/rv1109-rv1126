#!/bin/bash

function show_notice()
{
    echo ""
    echo -e "\033[32m===============Attention Please======================\033[0m"
    echo "1) This script is from owlvtech instead of rockchip."
    echo "2) You should backup your own change."
    echo "2) We will copy some files or overrid some files."
    echo "3) All the source files are in this directory"
    tree
    echo -e "\033[32m=====================================================\033[0m"
    echo ""
}

function apply_change()
{
    echo -e "\033[32m=========>>>apply change\033[0m"
    rsync -avzt ./* ../ --exclude=./vendor-patch.sh
    echo -e "\033[32m=========>>>apply change finished\033[0m"
}

function confirm_change()
{
    read -r -p "Are You Sure do that? [Y/n] " input

    case $input in
        [yY][eE][sS]|[yY])
            apply_change
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

show_notice
confirm_change

