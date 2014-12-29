---
layout: post
title: "Using rssdrop to receive and read feeds in Mutt"
description: ""
category: 
tags: [mutt, linux, rssdrop]
---
{% include JB/setup %}

### rssdrop

rssdrop is a perl script to deliver feeds to Maildirs. The [origin script](http://search.cpan.org/~acg/rssdrop/) is out of date and very buggy. So I create a [fork](https://github.com/petronny/rssdrop) and fixed lots of problems.

#### Install

The dependencies are `perl-xml-simple`, `perl-date-manip` and `perl-lwp-protocol-https`.

If you have solved the dependencies, clone my fork and rssdrop just works:

	git clone https://github.com/petronny/rssdrop

If you are using Archlinux, just install the `rssdrop` package from AUR.

#### Getting start

##### Initialize rssdrop

	$ rssdrop --mailfolder path/to/mailfolder

##### Subscribe to a new feed

	$ rssdrop -a archlinux https://www.archlinux.org/feeds/news/

##### Fetch items in your new feed

	$ rssdrop archlinux

##### Unsubscribe

	$ rssdrop -d archlinux

##### Fetch all new items in all feeds

	$ rssdrop

### Mutt

This part is simple, you can navigate to your feeds maildir or add it to spoolfile in your `.muttrc`.

But almost all the feed contents are html files, mutt will show them in plain text as default.
It's not quite human readable so you need a `html2txt` script to convert it.

### html2txt

Refer to [this blog](http://stromberg.dnsalias.org/~strombrg/mutt-html.html), `links` is a good choice because of its numbered links feature. I changed it to `elinks` for Chinese supporting. Make sure it's executable, and on your `$PATH`.

Here is an example of `html2txt`:

	#!/bin/sh
	# for mutt to view html e-mails
	
	elinks -dump "file://$@"
	
	#or
	#
	#lynx -force_html -dump "$@"
	#
	#or
	#
	#w3m -T text/html -F -dump "$@"

You also need a `~/.mailcap`:

	# for mutt to view html e-mails
	text/html;html2txt %s; copiousoutput

And configure the following options in your `~/.muttrc`:

	# for viewing html e-mails inside mutt.  See also .mailcap
	auto_view text/html
	alternative_order text/enriched text/plain text text/html

Now you can read all the html mails in mutt, not only the feeds.
