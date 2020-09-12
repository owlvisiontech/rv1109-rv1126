#!/bin/bash

RK_CFG_BUILDROOT=rockchip_rv1126_rv1109_facial_gate

BUILD_RET=0
START_TIME=$(date +%s)

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


