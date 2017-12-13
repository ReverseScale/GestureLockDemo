# GestureLockDemo
Swift 版手势滑动锁🔐

🔔：此 Demo 已更新，新版手势解锁基于 'GesturePassword' 实现，感谢作者 huangboju，下面的内容只是没删而已...

![](https://img.shields.io/badge/platform-iOS-red.svg) 
![](https://img.shields.io/badge/language-Swift-orange.svg) 
![](https://img.shields.io/badge/download-2.6MB-brightgreen.svg)
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

除了指纹和你的脸，还有一种常用的验证方式，就是手势验证，虽然安全性不高，但是也可以加层密不是

| 名称 |1.列表页 |2.设置页 |3.验证页 |
| ------------- | ------------- | ------------- | ------------- |
| 截图 | ![](http://og1yl0w9z.bkt.clouddn.com/17-10-27/17278377.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-10-27/86991446.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-10-27/82927257.jpg) |
| 描述 | 通过 storyboard 搭建基本框架 | 设置时展示 | 验证时展示 |


## Advantage 框架的优势
* 1.文件少，代码简洁
* 2.不依赖任何其他第三方库
* 3.图片样式随意设定
* 4.具备较高自定义性


## Requirements 要求
* iOS 10+
* Xcode 8+


## Usage 使用方法
### 第一步 调用方式
```
let lockVC = LockViewController(nibName:"LockViewController", bundle:nil)
NotificationCenter.default.post(name: Notification.Name(rawValue: "whClean"), object: nil)
switch tag {
case 100:
    lockVC.tag = 100
    break
case 101:
    lockVC.tag = 101
    break
case 102:
    lockVC.tag = 102
    break
    
default:
    break
}
self.present(lockVC, animated: true, completion: nil)
```


使用简单、效率高效、进程安全~~~如果你有更好的建议,希望不吝赐教!


## License 许可证
GestureLockDemo 使用 MIT 许可证，详情见 LICENSE 文件。


## Contact 联系方式:
* WeChat : WhatsXie
* Email : ReverseScale@iCloud.com
* Blog : https://reversescale.github.io
