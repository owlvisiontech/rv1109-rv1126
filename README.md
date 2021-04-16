# owlvtech-patch-rv1126
![输入图片说明](https://images.gitee.com/uploads/images/2021/0416/104602_63527ce4_8044273.png "50EMMC-IPC-removebg.png")
#### 介绍
- 在RV1126_RV1109_SDK基础上适配owlvtech开发板所需的补丁或文件，涉及屏幕显示和摄像头等基础功能。  
- 本仓库补丁会随着rockchip官方SDK更新而更新，如果你使用的SDK不是最新的请选择仓库中对应的TAG版本，否则可能出现不兼容的情况。  
- 建议使用Ubuntu18.04及以上版本的环境进行开发，从而节约搭建开发环境导致的时间成本。

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
| 路径        | 说明 |
|-----------|----|
| kernel    | 内核源码和DTS在这里，编译完成输出的zboot.img在kernel根目录里，里面包含了kernel和dts，如果有改到dts，我们需要重新烧录这个映像文件   |
| buildroot | 文件系统，库文件和一些APP都由这里组织编译，如果有改到APP和库或者有添加新的包的话需要重新编译单个模块，要看这里的详细编译规则  |
| external  | 主要是一些rk或者第三方的包在这里，比如rkmedia，rknn，rockface，rockx等   |
| app       | 这里主要是针对不同产品形态提供的demo APP，并且开机自启动，比如开发板用到的QFacialGate就在这里  |

----------

### 详细教程请持续关注OWL官方wiki：

 **[ :fa-link: OWLVisionTech Wiki For RV1126](https://gitee.com/owlvisiontech/owlvtech-patch-rv1126/wikis)** 

----------

#### 技术支持



- 针对从正规渠道有购买过的客户可以联系相关人员进行技术支持，包括整个系统的编译demo的运行相关

- 客户应该自己熟悉buildroot等编译框架

- 开发板以外的外设调试工作可以自己参考docs下面的官方文档进行，也接受方案定制 
