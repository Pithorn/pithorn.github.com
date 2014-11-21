---
layout: post
title: "Using gtest and gcov in cocos2dx"
description: ""
category: ""
tags: [gtest, android, cocos2dx]
---
{% include JB/setup %}
狂调半宿代码，深感与硬件打交道坑爹之处．
现暂记几处，以免后人入坑．

### cocos2dx的libtiff.a的main函数重定义

这样自己写的c文件都不能有main函数，gtest和gcov都不能用了.
[参见此贴](http://blog.linguofeng.com/archive/2013/04/17/cocos2d-x-ndkgdb.html) 
后简直雪中送炭．

现把我在自己的项目中的做法记下来：

* 切换到UnitTest分支
* 做git下的proj.android/exteral到cocos2dx/sebomber/proj.android/exteral的软连接
* 用git下的libtiff.a替换 cocos2d-x-2.1.5/cocos2dx/platform/third_party/android/prebuilt/libtiff/libs/armeabi/libtiff.a

#### 在jni/main3.cpp内做gtest单元测试

编译使用原来的编译方式

运行方式

	adb push cocos2d-x-2.1.5/sebomber/proj.android/libs/armeabi/libgame /data/
	adb shell
	export GCOV_PREFIX=/sdcard/mycov
	cd /data
	./libgame

* 运行结束后，生成的GCOV用的文件在/sdcard/mycov里

##### 获取GCOV文件到home

	adb pull /sdcard/mycov ~

将cocos2d-x-2.1.5/sebomber/proj.android/obj里面的.gcno文件
从手机里得到的.gcda, 和对应的.cpp文件放在一起
运行

	android-ndk/toolchains/arm-linux-androideabi-4.6/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gcov -b *.cpp

即可得到覆盖率报告及生成的报告文件

其中，libtiff.a是要自己重编译的．里面的libgtest也要重编译．

###gtest与cocos2dx冲突的问题

感谢[github.com/sfuku7/googletest_android_ndk-build](https://github.com/sfuku7/googletest_android_ndk-build)
给出了详尽的使用方式．

不过里面自带的那个libgtest是不能直接用的．
由于cocos2dx在编译时使用了frtti优化，我在写cocos2dx项目的单元测试文件时要么gtest不能用，要么cocos2dx不能用．
蛋疼了好几个小时，饭都没吃．最后想到把libgtest也开启frtti重编译一下就应该兼容了．

还是按照上面那个链接里面给出的googletest的编译方式
额外在googletest的jni/Application.mk中添加

	APP_CPPFLAGS := -frtti

然后做一个新的libgtest.

放到那个项目的sample/test_project/external下对应的地方测试能用．

按照sample/test_project/下的目录结构复制到cocos2dx的proj.android下，终于成功了．
