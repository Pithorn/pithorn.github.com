title: "The httpd.ini redirect rules for YOURLS"
date: 2015-02-02
tags: [windows,php,yourls]
---

The `.htaccess` for [YOURLS](http://yourls.org/) will not work on Windows servers.
Although YOURLS has noticed that and will create `web.config` automatically on Windows, my first url shortener site, [url.jingbei.li](http://url.jingbei.li/) still cannot redirect links as my expect.

<!--more-->
The reason is the Windows server I used is an old IIS server not a IIS7 server, the rewrite rules file should be `httpd.ini`, not `web.config`.

And `REQUEST_FILENAME` does not check the local files because it is relative. The current solution is writing all the file names and directory name manually to `httpd.ini`. It is a little silly, but works.

```dosini
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
```

#### PS

I've also resigned another domain, [pturl.tk](http://pturl.tk/). It does the same things that url.jingbei.li does, but much shorter. :)
