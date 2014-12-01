---
layout: page
title: Jingbei Li
tagline: Homepage
---
{% include JB/setup %}

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

### Contact

	Jingbei Li
	Department Of Computer Science, J12
	Tsinghua University
	Beijing, China
	100084
	TEL:+86-13389921221
	GitHub:petronny
	Email:jingbei.li@yahoo.com

