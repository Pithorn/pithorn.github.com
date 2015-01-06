---
layout: page
title: Homepage
group: navigation
tagline: Welcome!
---
{% include JB/setup %}

# 定场诗一首

	世人笑我太疯癫，我笑别人看不穿。
	不见五陵豪杰墓，无花无酒锄作田。

# Recent Posts

<div class="container">
<div class="posts">
	{% for post in site.posts limit 4 %}
	<div class="post">
		<h2>{{ post.title }}</h2>
		<h4>{{ post.date | date_to_string }}</h4>
		<p>{{ post.content | strip_html | truncatewords:80 }}</p>
		<a href="{{ post.url }}"><button class="btn btn-default">Read more</button></a>
	</div>
    {% endfor %}
</div>
</div>


<!--Github Activity-->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/octicons/2.0.2/octicons.min.css">
<link rel="stylesheet" href="//7sbplw.com1.z0.glb.clouddn.com/github-activity-0.1.0.min.css">

<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/mustache.js/0.7.2/mustache.min.js"></script>
<script type="text/javascript" src="//7sbplw.com1.z0.glb.clouddn.com/github-activity-0.1.0.min.js"></script>

# Recent Activity on Github

<div id="feed"></div>

<script>
GitHubActivity.feed({
	username: "petronny",
	selector: "#feed",
	limit: 5 // optional
});
</script>
