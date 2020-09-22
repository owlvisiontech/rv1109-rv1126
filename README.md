# owlvtech-patch-rv1126

#### 介绍
在RV1126_RV1109_SDK基础上适配owlvtech开发板所需的补丁或文件，涉及屏幕显示和摄像头等基础功能。

#### 软件架构
RK的整个SDK的编译主要是由buildroot组织的，在使用之前请详细阅读*docs/RV1126_RV1109*下面的相关文档，
从而了解SDK的组织方式以便于后期自己应用的集成和调试。

    ├── app
    ├── buildroot
    ├── build.sh -> device/rockchip/common/build.sh
    ├── device
    ├── docs
    ├── envsetup.sh -> buildroot/build/envsetup.sh
    ├── external
    ├── IMAGE
    ├── kernel
    ├── Makefile -> buildroot/build/Makefile
    ├── mm.sh
    ├── mkfirmware.sh -> device/rockchip/common/mkfirmware.sh
    ├── owlvtech-patch-rv1126
    ├── prebuilts
    ├── rkbin
    ├── rkflash.sh -> device/rockchip/common/rkflash.sh
    ├── rockdev
    ├── tools
    └── u-boot

##### 几个比较重要的目录

- **kernel** --------内核源码和DTS在这里，编译完成输出的zboot.img在kernel根目录里，里面包含了kernel和dts，如果有改到dts，我们需要重新烧录这个映像文件


- **buildroot**-----文件系统，库文件和一些APP都由这里组织编译，如果有改到APP和库或者有添加新的包的话需要重新编译单个模块，要看这里的详细编译规则


- **external**------主要是一些rk或者第三方的包在这里，比如rkmedia，rknn，rockface，rockx等。


- **app**-------------这里主要是针对不同产品形态提供的demo APP，并且开机自启动，比如开发板用到的QFacialGate就在这里

----------

#### 安装教程

1.  首先克隆/下载本仓库，如果收到的是压缩包请先解压，保持本仓库的文件夹和kernel u-boot等目录在同一级
2.  执行vendor-patch.sh脚本

> **cd owlvtech-patch-rv1126**  
> **./vendor-patch.sh**

3.  执行完上面的脚本，dts和其他代码或者补丁会覆盖原来SDK中的，如果有修改过，提前请做好备份

#### 使用说明
##### 初次编译
1.  打完补丁后就可以编译了，如果第一次使用，可以选择整个编译，在SDK根目录执行以下命令

> **./envsetup.sh**

2. 输入67，对应的应该是**rockchip\_rv1126\_rv1109\_facial\_gate**，然后回车确认
3. 开始进行编译

> **./build.sh**


##### 修改代码后的快速编译编译
- 如果对内核部分进行了修改，可以进入内核后单独编译内核，例如针对开发板的内核，进入kernel目录
> **make ARCH=arm rv11xx-owl-ddr4-facial-gate.img -j8**  
或者在根目录  
**./build.sh kernel**

- 如果对u-boot进行了修改可以在根目录输入
> **./build.sh uboot**

- 如果想要在文件系统中增加某些应用程序或者库，在根目录执行
> **./mm.sh menuconfig**

然后在弹出的界面里进行选择，完成后保存

- 如果想单独编译某个库或者某个应用程序，在根目录执行<包的名字>-rebuild，例如
> **./mm.sh rkmedia\-rebuild**

将会重新编译rkmedia

> **./mm.sh QFacialGate\-rebuild**

将会重新编译QFacialGate应用程序  
最后要将文件系统打包或者将相关的可执行文件或库adb push到开发板上去

> **./mm.sh**

直接运行./mm.sh不加参数的话，默认等于在buildroot目录下执行make命令，也就是编译所有并打包，如果没有修改的话仅仅打包文件系统

> **buildroot/output/rockchip\_rv1126\_rv1109\_facial\_gate/images**

打包后文件系统就在上面的路径里

> **cd buildroot/output/rockchip\_rv1126\_rv1109\_facial\_gate/target**

最终生成的文件都会在这里

> **cd buildroot/output/rockchip\_rv1126\_rv1109_facial\_gate/host/bin**

用到的编译器会在这个路径，可以用里面的GCC/G++等编译自己的程序

##### 镜像文件的烧写

首先按住板子上的update键(靠近边缘)，在按一下reset键(靠近中间)，然后用从OTG口连接到电脑，linux上直接可以在根目录运行脚本烧写，windows则可以用Android Tool烧写

> **sudo ./rkflash.sh**

默认会烧写全部镜像文件，如果要单独烧写需要后面加参数，具体使用说明可以查看help

> **./rkflash.sh -h**


#### 技术支持



- 针对从正规渠道有购买过的客户可以联系相关人员进行技术支持，包括整个系统的编译demo的运行相关

- 客户应该自己熟悉buildroot等编译框架

- 开发板以外的外设调试工作可以自己参考docs下面的官方文档进行，也接受方案定制 
