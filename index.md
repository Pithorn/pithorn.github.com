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
x            <a href="{{ post.url }}">Read more...</a><br><br>
	</h5>
    {% endfor %}
</ul>


<!--Github Activity-->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/octicons/2.0.2/octicons.min.css">
<link rel="stylesheet" href="/assets/github-activity/github-activity-0.1.0.min.css">

<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/mustache.js/0.7.2/mustache.min.js"></script>
<script type="text/javascript" src="/assets/github-activity/github-activity-0.1.0.min.js"></script>

### Recent Activity on Github.com

<div id="feed"></div>

<script>
GitHubActivity.feed({
	username: "petronny",
	selector: "#feed",
	limit: 5 // optional
});
</script>
