---
layout: post
title: "The httpd.ini redirect rules for YOURLS"
description: ""
category: 
tags: [windows,php,yourls]
---
{% include JB/setup %}

The `.htaccess` for [YOURLS](http://yourls.org/) is not working for Windows server.
Although YOURLS has noticed that and will create `web.config` instead, my first url shortener site, [url.jingbei.li](http://url.jingbei.li/) still cannot redirect links as my expect.

The reason is the Windows server I used is a IIS server not IIS7 server, the rewrite rules file should be `httpd.ini`, not `web.config`.

And `REQUEST_FILENAME` does not check the local files because is relative. The solution is write all the file names and directory name manually in `httpd.ini`. It is a little silly, but works.

{% hightlight dosini %}
[ISAPI_Rewrite]
RewriteRule /admin(.*) /admin$1 [L]
RewriteRule /css(.*) /css$1 [L]
RewriteRule /images(.*) /images$1 [L]
RewriteRule /includes(.*) /includes$1 [L]
RewriteRule /js(.*) /js$1 [L]
RewriteRule /pages(.*) /pages$1 [L]
RewriteRule /user(.*) /user$1 [L]
RewriteRule /(.*).html /$1.html [L]
RewriteRule /(.*).php /$1.php [L]
RewriteRule /.+ /yourls-loader.php [L]
{% endhiglight %}

#### PS

I've also resigned another domain, [pturl.tk](http://pturl.tk/). It does the same things that url.jingbei.li does, but much shorter. :)
