title: "Openwrt 15.05rc1 HG255D的ipv6支持"
date: 2015-08-26
tags: [openwrt, ipv6]
---

感谢[rjjacky](blog.rjjacky.info)把他的HG255D转手给我折腾openwrt了。这次折腾的主要目标是ipv6支持。

### 首先是蛋疼的固件

openwrt对hg255d的支持至少我从15.05rc2就已经看不到了。。我先尝试自己编译一个。

<!--more-->
openwrt自己的wiki上的编译guide就好几种。。根本不知道是哪个，并且除了`make menuconfig`以外还有很多隐藏的地方要改。
经过几次编译，没有一次flash进去能用的。。。放弃。。

后来从[此处](http://www.right.com.cn/Forum/thread-167159-1-1.html)下载了一个15.05-rc1带部分ipv6的固件，总算刷进去了。

这个固件还算不错，wan和wan6直接就获取到ipv6地址了，lan内部能获取到一个由dhcpv6分配的有奇怪prefix的ipv6地址。

不过没有意义，lan内的机器还是访问不了ipv6的外网。

于是，我的第一反应：

### 做个ipv6的nat

#### part1

参见[这篇blog](http://www.7forz.com/2555/)

* opkg装kmod-ip6tables，kmod-ipt-nat6。

>装的时候的小插曲：源里面有个链接失效了，注释掉吧先。。

* 然后运行 `ip6tables -t nat -L` 检测一下。

不过他之后这句

> 在开机启动脚本上添加ifconfig br-lan xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx/64

看起来有点不雅。。

#### part2

于是我想到了之前看到的知乎上的[这个问题](http://www.zhihu.com/question/29667477/answer/47149165)的第一个回答，可以把wan获取到的ipv6地址弄到lan上去。

所以下一步的配置是

* 在LuCI界面删除LAN-ipv6配置下的Global ULA-Prefix里面的数值
* 修改/etc/config/dhcp的对应片段如下，请用脑子改

```
config dhcp 'lan'
	option interface 'lan'
	option start '100'
	option limit '150'
	option leasetime '12h'
	option ra 'hybrid'
	option dhcpv6 'hybrid'
	option ndp 'hybrid'
	option ra_management '1'
config dhcp 'wan6'
	option interface 'wan'
	option dhcpv6 'hybrid'
	option ra 'hybrid'
	option ndp 'hybrid'
	option master '1'
```
* 确保odhcpd是处于开机启动状态

> 如果现在重启，正常的情况应该是，LAN会获得wan处的ipv6地址（同为2001开头），然后LAN下面的设备各自获得自己的ipv6地址。
> 这样连radvd也不用管了～

#### part3

好现在回到part1的那篇blog，做最后一步：

* 在 /etc/firewall.user 中加入

```
ip6tables -t nat -I POSTROUTING -s xxxx:xxxx:xxxx:xxxx::/64 -j MASQUERADE  #其中的IP是LAN的前4段
```

* Reboot and enjoy～
