---
layout: post
title: "用raspberry pi做一个android机器人"
description: ""
category: 
tags: [raspberry pi]
---
{% include JB/setup %}

呼！终于从deadline里面爬出来一会儿让我有时间把这个之前开的坑填了。。

### Introduction

怎么想起来做这个的呢。。一开始是我的师兄的《人工智能基础理论选讲》课，说是要做大作业，做啥都行，软硬都能报销。
然后就引起我兴趣，为啥不借此机会好好地做(mai)开(mai)发(mai)呢。。

下一个问题就是做什么，第一反应，要有实用性。扫地机好了！可是听说别的组也要做扫地机，算了。。

后来想地上跑的不行，咱们就来天上飞的吧！搞一个智能无人机好了。正看着大四轴呢，老师架不住了。。说尽量别过1k。。

得得得，慢慢想吧，这时候我从知乎上看到了这么个东西

![zhihu-raspberrypi](http://7sbplw.com1.z0.glb.clouddn.com/zhihu-raspberrypi.png)

其实没啥意思，我就狂笑了6个小时就不笑了。。。这不关键。。先做一个交作业吧。。

### The Model

他说什么就做什么呗，先买空心的android模型。这个还不太好找，找个大小合适的能放树莓派的还真的挺少的。。

最后找到的就是它：

![android-money-box](http://7sbplw.com1.z0.glb.clouddn.com/android-money-box.jpg)

其实是一个存钱罐，腿也不好看。不过只能先这样了。。下一个档位的就和人差不多大小了

接下来就要把脑袋锯了先。这个要归功于建筑系的同学了，家伙真全啊。。要是能用电锯就好了

![step1-1](http://7sbplw.com1.z0.glb.clouddn.com/step1-1.jpg)

但是实际上并没有电。。得在上课时间段才有电。不过这难不倒我：

![step1-2](http://7sbplw.com1.z0.glb.clouddn.com/step1-2.png)

费了半天劲总算是锯下来了。。接下来是钻掉眼睛。。//全靠我同学，我反正是这辈子没动过钻头。。

![step1-3](http://7sbplw.com1.z0.glb.clouddn.com/step1-3.png)

### The Motor

电机长这样，让它驱动脑袋貌似还缺点什么。。。所以我就去补买了一个小车轮

![wheel-taobao](http://7sbplw.com1.z0.glb.clouddn.com/wheel-taobao.jpg)

看起来有四驱车轮大小。。但是拿到手里一看。。

![wheel](http://7sbplw.com1.z0.glb.clouddn.com/wheel.jpg)

卧槽吓死我了。。。不过好在还能装下。。

![step2-1](http://7sbplw.com1.z0.glb.clouddn.com/step2-1.png)

里面垫了若干木头片和瓶盖。。

下一个问题就是电机怎么固定在脑袋下面呢。。简单想了想有下面两种方案：

- 拿个支架给它支在中间

![wheel-1](http://7sbplw.com1.z0.glb.clouddn.com/wheel-1.png)

- 拿个板给它架起来

![wheel-2](http://7sbplw.com1.z0.glb.clouddn.com/wheel-2.png)

按照原计划应该是什么东西都要放在存钱罐里面的，板子啊，电池啊什么的。所以肚子里面还是空一些好吧。

![wheel-3](http://7sbplw.com1.z0.glb.clouddn.com/wheel-3.png)

木板是用激光雕的，不过掰的不是很好看_(:з」∠)_ //感谢建筑系同学的技术支持。。

//对。。就是这个农夫山泉的瓶盖。。

#### The Motor Driver

电机自己是不能动的，还需要买一块驱动板

![motor-driver](http://7sbplw.com1.z0.glb.clouddn.com/motor-driver.jpg)

然后把正极，负极，4个针脚接到树莓派对应的接口上。

![pins](http://7sbplw.com1.z0.glb.clouddn.com/pins.png)

简单地说，就是2,6,11,12,13,15这些，当然接别的也能用

然后参考[这里](http://www.codelast.com/?p=5232)，得知只要依次向4个端口写1，步进电机就会转了！写的频率越高，转的速率越快。

### The Camera

摄像头买的是树莓派专用的

![camera](http://7sbplw.com1.z0.glb.clouddn.com/camera.png)

下面就是到关键的人脸识别部分了！

第一反应，[SimpleCV](http://simplecv.org/)，同组的小伙伴糙快猛的写了一个出来。与此同时，我来搭片场，学名叫简易式计算机视觉工作室。。

![cvlab](http://7sbplw.com1.z0.glb.clouddn.com/cvlab.png)

识别出来的是这样

![simplecv](http://7sbplw.com1.z0.glb.clouddn.com/simplecv.png)

看起来还不错是吧。不过动一下立马就完蛋了。。这个没有tracking功能。。

那就找带tracking的吧，比如[这个](https://github.com/kylemcdonald/FaceTracker)，效果是这样

![facetracker](http://7sbplw.com1.z0.glb.clouddn.com/facetracker.png)

卧槽连半张脸都能识别。

### The Lens

不过还有一个问题就是摄像头的视野不能覆盖到中间。。。想一想这个玩意只能侧着看着你。。

机智的我立刻想到加一个鱼眼镜头不就好了。买买买。。

![fisheye](http://7sbplw.com1.z0.glb.clouddn.com/fisheye.jpg)

不过由于形变，上面的两个人脸识别的东西应该性能会下降吧。。果然SimpleCV的那个基本上啥都识别不出来了。。第二个倒是还行，不过有时候会识别到奇奇怪怪的地方去。。

一个很自然的想法就是把鱼眼镜头形变的图像形变回去，简单调查一下果然这种东西还是有的

![fisheye-calibration](http://7sbplw.com1.z0.glb.clouddn.com/fisheye-calibration.png)

不过小伙伴告诉我这个东西做好了直接就能发paper了。。网上找的代码效果都不怎么明显。。有的还会造成现有的识别帧率下降。。
所以展示的时候我们果断的直接把这个模块给去了。。然后站的不是那么的偏。。

最终效果就是识别到人，电机极快的转过去，然后再识别。转的过程中是不识别的，所以还没有那么流畅，不过先这样吧。。
### The Raspberry Pi

树莓派是啥我就不多说了，得名是因为这个东西红红的像树莓做的派一样。。不过现在国内能买到的都是绿的了吧。

![red-raspberrypi](http://7sbplw.com1.z0.glb.clouddn.com/red-raspberrypi.png)

我就有一个红色的，是当年最早出的时候就买的:)

作为ArchlinuxCN的maintainer之一，系统果断arch，虽然我们并没有进军archlinuxarm...

### The Sound Card

仅仅是图像识别绝对满足不了我的脑洞。//好吧，其实是为了找理由能结合实验室方向。。

玩一玩语音好了。剧本是这样：想想你回到房间，一大堆Andriod齐刷刷的看着你。。。然后我大喊一声"同志们好！"，答"首长好"，"同志们辛苦啦！"，"为人民服务！"。。。//大夫我码完这个就去吃药。。

拆开来说就是下面这三个部分

- 语音识别
- 命令分析
- 语音合成

甭管怎么说，先录一段音出来再说吧。嗯？怎么没有用。。汗，原来自带的声卡只有输出没有输入。。。这都行。。先补买一个usb声卡好了。。切换声卡就用asoundconf

### The Automatic Speech Recognition

先找现成的，github上的这个[PiAUISuite](https://github.com/StevenHickson/PiAUISuite)里面的VoiceCommand基本上就是我想要的功能了，[这里](http://blog.csdn.net/zebra2011/article/details/24258065)还有一份中文的说明，看起来很靠谱的样子。。

直接编译运行，并没有什么鸟用。。。一看，怎么是google speech api挂了？apiKey过期了吗，赶紧去换一个。搜出来一看，原来不仅仅是apiKey过期了的问题。。google speech api关了。。当时我心中就冒出"最大皮革厂倒闭了，老板带着小姨子跑了，还我血汗钱"的音效。。

得得得，转投其他api。听说科大讯飞做的比较火，就先试一试吧。

识别(ASR)的过程中踩了下面这些坑：

- 必须是指定的采样频率
- 必须是指定的整数编码
- 必须是单声道
- 必须使音量在恰当的范围

这几个坑真是搞的我一头雾水，根本不知道怎么回事，识别出来都"红红火火恍恍惚惚"，耗了好一段时间。。

词典里面写了"同志们好"和"同志们辛苦啦"//其他彩蛋就不说了

### The VoiceCommand

虽说google speech api倒闭了，但是这个的其他部分还能用。

可以定义命令集，命令也可以有一些通配的能力。可以通过强制输入语音识别的内容来绕过倒闭的google api。

不过这个代码里面有bug你敢信。。。修bug的过程中发现这个代码里面用c++调了大量的系统命令。。。然后代码恶心的我要死，最后看不下去了。。shell直接写吧
{%highlight sh%}
while true
do
        echo "start"
        arecord -D plughw:Set -f S16_LE -t wav -d 3 -r 16000 -q /dev/shm/noise.wav
        echo "end"
        volume=`sox /dev/shm/noise.wav -n stats -s 16 2>&1 | awk '/^Max\\ level/ {print $3}'`
        threshold=5
        if [ $(echo "$volume > $threshold" | bc) -eq 1 ]
        then
                echo "$volume is bigger than $threshold"
                command=`~/CN_voicecommand/bin/asr_sample d5f83239c52172627246d62227fb4eea /dev/shm/noise.wav |grep input | awk '{print $3;exit}' |sed 's/input=//g'`
                echo "command:" $command
                if [ -n "$command" ]
                then
                        if [ "$command" = "id=nomatch" ]
                        then
                                continue
                        fi
                        ~/PiAUISuite/VoiceCommand/voicecommand -I $command
                fi
        fi
done
{%endhighlight%}
写出来不就那么几行吗。。费那么多劲干什么。。不过同时也能看出来，现在就是看见start，然后截3秒，识别一段时间。识别的过程中是什么都听不见的，这个就算下一步的改进目标吧。

### The Text To Speech

识别出来命令后，我就直接把命令规则定义好了：

	同志们好==tts 首长好
	同志们辛苦了==tts 胃人民服务
	同志们辛苦啦==tts 胃人民服务

为什么是"胃"。。因为科大讯飞的这个还是太弱了。。

google speech api的tts部分也挂了，也得用科大讯飞的。然后我们不知道怎么就把一个正常的女性播音员的声音改成了下述这个样子：

[tts_sample](http://7sbplw.com1.z0.glb.clouddn.com/tts_sample.wav)

萌萌的是吧。。播放设备用的是这个

![speaker](http://7sbplw.com1.z0.glb.clouddn.com/speaker.jpg)

### The Battery

电池就选了我早就觊觎很久了的[PiJuice](Robo://www.pijuice.com/)

![pijuice](https://www.pi-supply.com/wp-content/uploads/2015/03/photo-original-300x300.jpg)

不过他们并没有货。。自从我下单到现在还是没有发货。。

### The Robot

由于电池没到，所有东西肯定不能都放到肚子里面了。。只好把设计改为一部分放在外面了。

![raspberrypi-shell](http://7sbplw.com1.z0.glb.clouddn.com/raspberrypi-shell.png)

给树莓派买了个外壳当底座。另外为了走线把那个存钱罐的腿也锯掉了一半。。然后就把它放在底座上了

接下来就是装摄像头。这个不好办，因为这个头是球面，但是里面的轴是圆柱，要斜着把它装上去，还要固定。不过这难不倒我

![robot-1](http://7sbplw.com1.z0.glb.clouddn.com/robot-1.jpg)

基本上把我所有手边能用到的材料都用上了。。完整组装好是这样

![robot-2](http://7sbplw.com1.z0.glb.clouddn.com/robot-2.jpg)

来一张头部特写

![robot-3](http://7sbplw.com1.z0.glb.clouddn.com/robot-3.jpg)

看起来还是挺帅气的～另外放一起特别有

![terminator](http://7sbplw.com1.z0.glb.clouddn.com/terminator.jpg)

的感觉有木有啊！！

### Q & A

Q.为什么只有一只眼了。。。

因为双摄像头的扩展板太贵了。。够买两个树莓派了。。

Q.原来的那两个眼睛的洞呢？

![robot-4](http://7sbplw.com1.z0.glb.clouddn.com/robot-4.jpg)

你刚才说啥？

Q.现在这个东西在哪呢？

就在我实验室的桌子上当电子宠物了。。我把语音识别的部分关了，会一直盯着我看。。。
