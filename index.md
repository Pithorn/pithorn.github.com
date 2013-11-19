---
layout: page
title: 首页
tagline: pithorn的个人博客
---
{% include JB/setup %}

## 最近动态
<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>
