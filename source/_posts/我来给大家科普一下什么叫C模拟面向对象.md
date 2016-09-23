title: "我来给大家科普一下什么叫C模拟面向对象"
date: 2015-12-29
tags: [c,c++]
---

#### Introduction
唉。。这个题本来是我给本校一门C++的课出的期末考试题，无奈被批"平常老嘱咐不要写C风格的程序"，然后就被干掉了。。但是这个技能本身还是有一定意义的，在此我就直接把原题目的空都填好了分享给大家。

注：下面这堆中，声明都是真的，实现都是我口胡的。最近口胡能力越来越强了。。。

<!--more-->
#### 题目描述
Pebble是一款于2013年初上市的智能手表，具有一块类似Kindle的黑白电子墨水屏，支持蓝牙链接以便从手机获取消息通知。
相对于今天才上市的Apple Watch，Pebble更加开放和友好的开发环境赢得了广大Geek的青睐。

![pebble](http://7sbplw.com1.z0.glb.clouddn.com/pebble.png)
![pebble-time](http://7sbplw.com1.z0.glb.clouddn.com/pebble-watchface.png)

虽说开发环境比较友好，但是，并！没！有！C++编译器，基本的开发语言只有C。。。

__但是，这并不妨碍你使用C来开发一个简单的Pebble程序__，通过本学期的学习，你已经掌握了C语言的很多语法。

|C和C++共同的语法部分（本题中可以使用）|C语言不具备的语法（本题中无法使用的）|
|基本的数据类型|class,namespace,template|
|数组及指针|struct中无法包含函数体|
|循环体及函数体|string数据类型|
|宏语句|new与delete语句|

__并且，即便没有class，也并不妨碍你使用面向对象的思想来开发程序。__

我们现在就来尝试使用C来模拟出一个类，由于没有class，我们只能先用struct来构建出他的数据部分：
```c
#include <stdlib.h>
```
我们现在就来尝试使用C来模拟出一个类，由于没有class，我们只能先用struct来构建出他的数据部分：
```c
struct GPoint {
	unsigned int x,y;//表示坐标
};
```
接下来我们可以用下面的语句来定义GPoint类型的对象了
```c
struct GPoint a_point;
```
为了调用方便，不如就用typedef把它改造的更像类一些
```c
typedef struct GPoint GPoint;
```
现在我们就可以摆脱那个struct啦
```c
GPoint another_point;
```

下面这个宏给我们演示了如何模拟出一个构造函数
利用{}来构建一个结构对，接下来强制类型转换成GPoint类型并返回
```c
#define GPoint(x, y) ((GPoint){(x), (y)})
```
调用就像这样
```c
a_Point=GPoint(0,0);
```

上面的struct和typedef两句还可以合并起来写
```c
typedef struct GSize {
	unsigned int w,h;//表示宽度和高度
} GSize;
#define GSize(w, h) ((GSize){(w), (h)})
```

接下来我们来构造一个内嵌其他类型的类
```c
typedef struct GRect {//描述一个矩形方框
	GPoint origin;//表示这个矩形的原点，即左上角
	GSize size;//表示这个矩形的大小
} GRect;
```
现在我们来仿写一个GRect类型的构造函数
```c
#define GRect(x, y, w, h) ((GRect) { {(x), (y) }, {(w), (h)}})
```

对于简单的，不含函数的类，我们用上面的办法就可以解决了。
对于一些更基本的类，甚至可以这样
```c
typedef enum GColor {
	GColorClear,GColorBlack
} GColor;
```

接下来我们来用C来构建一个复杂的基类
```c
typedef struct Layer Layer;
struct Layer {
	//对于复杂的类我们需要一个this指针
	Layer* this;
	GRect bounds;
	//...
};
```
现在我们来实现这个类的构造函数
```c
Layer* layer_create(GRect bounds) {
	Layer layer;
	Layer* this=&layer;
	this->bounds=bounds;
	return this;
}
```
同样还要有析构函数
```c
void layer_destroy(Layer* this) {
	free(this);
}
```
接下来定义一个成员函数，开头附加类名来表示这个类的归属
```c
GRect layer_get_bounds(Layer* this) {
	return this->bounds;
}
```
以及其他成员函数，他们都以类名开头，第一个参数是这个类的对像的指针。对于一个静态函数，可以这样。
```c
void layer_add_child(Layer *parent, Layer *child);
```

接下来我们来模拟继承自Layer和Text两个类的子类TextLayer
```c
typedef struct TextLayer TextLayer;
struct TextLayer {
	Layer* layer;//存储基类的指针
	TextLayer* this;//存储子类的指针
	//...
};
```
接下来我们来实现子类的构造函数
```c
TextLayer* text_layer_create(GRect bounds) {
	TextLayer textLayer;
	TextLayer* this= &textLayer;
	this->layer=layer_create(bounds);
	return this;
}
```
以及析构函数
```c
void text_layer_destroy(TextLayer* this) {
	layer_destroy(this->layer);
	free(this);
}
```
以及一些成员函数
```c
Layer* text_layer_get_layer(TextLayer* this) {
	return this->layer;
}
void text_layer_set_text(TextLayer* text_layer, const char* text);
const char* text_layer_get_text(TextLayer* text_layer);
void text_layer_set_background_color(TextLayer* text_layer, GColor color);
void text_layer_set_text_color(TextLayer* text_layer, GColor color);
```
以及其他成员函数

同样我们还有另一个继承自Layer的类，用来存储图片
```c
typedef struct BitmapLayer BitmapLayer;
struct BitmapLayer {
	Layer* layer;
	BitmapLayer* this;
	//...
};
```

现在我们还有一个同时继承自TextLayer和BitmapLayer的类
```c
typedef struct TextBitmapLayer TextBitmapLayer;
struct TextBitmapLayer {
	TextLayer* textLayer;
	BitmapLayer* bitmapLayer;
	//...
};
```
我们来仿照C++解决类似情况的手法实现这个类的构造函数
```c
TextBitmapLayer* text_bitmap_layer_create(GRect bounds) {
	TextBitmapLayer textBitmapLayer;
	TextBitmapLayer* this=&textBitmapLayer;
	this->textLayer=text_layer_create(bounds);
	BitmapLayer bitmapLayer;
	this->bitmapLayer=&bitmapLayer;
	this->bitmapLayer->this=&bitmapLayer;
	this->bitmapLayer->layer=this->textLayer->layer;
	return this;
}
```
以及析构函数
```c
void text_bitmap_layer_detroy(TextBitmapLayer* this) {
	text_layer_destroy(this->textLayer);
	free(this->bitmapLayer);
	free(this);
}
```

现在我们就来为pebble实现一个右图中那个简单的watchface吧
```c
#include <pebble.h>
static Window* s_main_window;//表示watchface所属的窗口，即最顶层的Layer
static TextLayer* s_time_layer;//用于显示时间
static void update_time() {
//定义每单位时间过去以后的动作
static void tick_handler(struct tm* tick_time, TimeUnits units_changed) {
	//获取本地时间
	time_t temp = time(NULL);
	struct tm* tick_time = localtime(&temp);
	//生成可读的时间格式
	static char s_buffer[8];
	strftime(s_buffer, sizeof(s_buffer), "%H:%M", tick_time);
	//把可读的时间字符串写到全局的TextLayer中
	text_layer_set_text(s_time_layer, s_buffer);
}
static void main_window_load(Window* window) {
	//window包含了一个基础的layer，覆盖了整个显示屏
	Layer* window_layer = window_get_root_layer(window);
	//获取显示屏的大小
	GRect bounds = layer_get_bounds(window_layer);
	//我们来把中间那个TextLayer放到合适的位置
	s_time_layer = text_layer_create(GRect(0, 52, bounds.size.w, 50));
	//设置背景和文字的颜色
	text_layer_set_background_color(s_time_layer, GColorClear);
	text_layer_set_text_color(s_time_layer, GColorBlack);
	//设置字体和文字的摆放方式
	text_layer_set_font(s_time_layer, FONT_KEY_BITHAM_42_BOLD);
	text_layer_set_text_alignment(s_time_layer, GTextAlignmentCenter);
	//把这个层添加到Window的所属层中，否则不会显示出来
	layer_add_child(window_layer, text_layer_get_layer(s_time_layer));
}
static void main_window_unload(Window* window) {
	//定义这个Window卸载时的动作，要把所有所属层都释放掉
	text_layer_destroy(s_time_layer);
}
static void init() {
	//创建一个Window
	s_main_window = window_create();
	//定义了这个Window的加载与卸载时的动作，用了函数指针来描述多态，看不懂可无视
	window_set_window_handlers(s_main_window, (WindowHandlers) {
		.load = main_window_load,
		 .unload = main_window_unload
	});
	//把我们的watchface压入Window栈的栈顶，这样就可以显示出来了
	//第二个参数表示启用过场动画
	window_stack_push(s_main_window, true);
	//定义多久触发一次tick_handler
	tick_timer_service_subscribe(MINUTE_UNIT, tick_handler);
}
int main(void) {
	//先创建出我们的watchface
	init();
	//这一步我们的watchface就持续运行啦
	app_event_loop();
	//watchface退出时的动作
	window_destroy(s_main_window);
}
```
编译，运行！但是发现这个watchface显示的时间有时候会与真实时间有误差，请问误差最大是多少？为了降低误差，有什么办法吗？

> 最大偏差一分钟，因为每一分钟才调用一次tick_handler。把MINUTE_UNIT改成SECOND_UNIT就好了。

#### 点评

我是忍住了才没喷AppleWatch...完全不可用的待机，不防水，必须和ios应用绑定。。真是不行不行的了。。

另外关于多态的实现，其实我早就想用函数指针了，写基类的时候写写删删了好几次。。。无奈还是没写。

