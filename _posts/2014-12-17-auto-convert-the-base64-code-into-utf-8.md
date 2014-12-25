---
layout: post
title: "Auto convert the base64 code in Abook"
description: ""
category: 
tags: [abook linux mutt ]
---

[Abook](http://abook.sourceforge.net/) is a text-based addressbook program designed to use with [mutt](http://www.mutt.org/) mail client.

There is a chapter about using abook with mutt in the [ArchWiki](https://wiki.archlinux.org/index.php/Mutt#Abook).

If you want to use __Abook__ instead of aliases, remove the aliases configuration in `.muttrc` and add this:

	set query_command= "abook --mutt-query '%s'"
	macro index,pager  a "<pipe-message>abook --add-email-quiet<return>" "Add this sender to Abook"
	bind editor        <Tab> complete-query

But sadly, the command `abook --add-email-quiet` always gets a string like "=?utf-8?B?55m+5ZCI5LuZ5a2Q?=" which is a base64 encoded string.

To convert the base64 code and automatically fits the correct encoding, you can use a shell function:

	conv() {
		eval `echo $1 | awk -F '?' '{ print "echo " $4 " | base64 -d | iconv -f " $2 }'`
	}
    

	$ conv name==?utf-8?B?55m+5ZCI5LuZ5a2Q?=

Or a python sscript like this:

	#!/usr/bin/env python2
	# -*- coding: utf-8 -*-
	import email
	import email.header
	import sys
	import re

	def abookdecode(origin_name):
	    name=email.Header.decode_header(origin_name)
		if name[0][1] is None:
		    return name[0][0]
		else:
		    return name[0][0].decode(name[0][1]).encode('utf-8')

	    if '__main__'==__name__:
		infile=open(sys.argv[1],"r")
	    content=infile.readlines()
	    infile.close()
	    outfile=open(sys.argv[1],"wb")
		for line in content:
		if line[0:4]=='name':
		    outfile.write(line[0:5]+abookdecode(line[5:-1])+'\n')
		    else:
			outfile.write(line)
	    outfile.close()

And then change your `.muttrc` to call the script:

	macro index,pager  a "<pipe-message>abook --add-email-quiet && abook-decode ~/.abook/addressbook<return>" "Add this sender to Abook"

Now the addressbook will be written correctly.

{% include JB/setup %}
