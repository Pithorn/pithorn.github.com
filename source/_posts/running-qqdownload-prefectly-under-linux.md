title: "Running QQDownload prefectly under linux"
date: 2014-10-21
tags: [wine,linux]
---

[QQDownload](http://xf.qq.com/index.html)(QQ旋风, which means "QQ tornado") is a download manager and bittorrent client developed by Tencent Holdings Ltd.

Comparing with its main competitor, Xunlei, QQDownload is more easier to handle by wine.

<!--more-->
Here is a tutorial for running QQDownload 4.8 Beta using wine:

1. Create a new 32-bit wineprefix

	export WINEARCH=win32
	export WINEPREFIX=somewhere winetricks

2. If wine ask you to install `gecko` and `mono` plugins, permit it.
3. Install `windowscodecs` to your wineprefix using `winetricks` GUI.
4. Then install `riched20`, `riched30` and `wininet` to your wineprefix using `winetricks` GUI.
5. Finally you need a Chinese font for all charactors. The `fakeChinese` in `winetricks` is a good choice.
6. Have fun! You may need a desktop launcher.

### PS

if you have permission to use the [Tencent offline downloading](http://lixian.qq.com/login.html), 
such as VIP account or gained LV8 in QQDownload, I recommend you to try out another python script, [xfdown](https://github.com/kikyous/xfdown).

Xfdown now has a awesome Tui with color support, wow.
