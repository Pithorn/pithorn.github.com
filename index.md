---
layout: page
title: Jingbei Li
tagline: Homepage
---
{% include JB/setup %}

### 定场诗一首

	世人笑我太疯癫，我笑别人看不穿。
	不见五陵豪杰墓，无花无酒锄作田。

### Recent Posts

<ul >
    {% for post in site.posts limit 4 %}
    <li>
    	<h4>
    		<a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a>
    		{{ post.date | date_to_string }}
    	</h4>
    </li>
        {{ post.content | strip_html | truncatewords:15 }}<br>
    	<h5>
            <a href="{{ post.url }}">Read more...</a><br><br>
	</h5>
    {% endfor %}
</ul>

