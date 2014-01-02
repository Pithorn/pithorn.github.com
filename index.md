---
layout: page
title: 首页
tagline: pithorn的个人博客
---
{% include JB/setup %}

### 定场诗一首

	世人笑我太疯癫，我笑世人看不穿； 
	不见五陵豪杰墓，无花无酒锄作田。

### Personal Tags

`THU学生` `Linuxer`

## 最近动态
<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

## Contact
<img src="favicon.ico" height="50" width="50" />

	Li Jingbei
	Department Of Computer Science, J12
	Tsinghua University
	Beijing, China
	100086
	TEL:+86-13389921221
	GitHub:github.com/Pithorn
	Email:jingbei.li@yahoo.com


