---
layout: post
title: "A simple script to check your ruby library version"
description: ""
category: 
tags: [linux,ruby,shell]
---
{% include JB/setup %}

Most ruby packages are not maintained by the Archlinux repository, I installed them locally then added `~/.gem/ruby/2.1.0/bin` to `$PATH`.

Although the ruby version is `2.1.5`, it uses `2.1.0` as the library version. It feels silly if I change it manually every time, so I have to find a way to check it automatically.

Refer to this [post](http://forum.ubuntu.com.cn/viewtopic.php?f=48&t=466400), the output of `ruby -e 'puts $LOAD_PATH'` includes what I need.

{% highlight sh %}
/usr/lib/ruby/site_ruby/2.2.0
/usr/lib/ruby/site_ruby/2.2.0/x86_64-linux
/usr/lib/ruby/site_ruby
/usr/lib/ruby/vendor_ruby/2.2.0
/usr/lib/ruby/vendor_ruby/2.2.0/x86_64-linux
/usr/lib/ruby/vendor_ruby
/usr/lib/ruby/2.2.0
/usr/lib/ruby/2.2.0/x86_64-linux
{% endhighlight %}

Then use `sed` and `grep` to find it out.

{% highlight sh %}
ruby -e 'puts $LOAD_PATH' | sed "s/\/usr\/lib\/ruby\///g" |grep '^[0-9\.]*$'
{% endhighlight %}

Finally I added the following line to `.zshrc` and it works fine.


{% highlight sh %}
ruby_version=`ruby -e 'puts $LOAD_PATH' | sed "s/\/usr\/lib\/ruby\///g" |grep '^[0-9\.]*$'`
path=($path ~/.gem/ruby/$ruby_version/bin)
{% endhighlight %}

BTW, this script can also be used in the PKGBUILD of ruby gem packages.
