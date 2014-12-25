---
layout: post
title: "Showing colors in the Byobu custom scripts"
description: ""
category: 
tags: [linux,byobu,tmux]
---
{% include JB/setup %}
[Byobu](byobu.co) is a frontend for screen or tmux.

But the custom script sample in the manual page does not working in tmux.

	#!/bin/sh
	printf "\005{= bw}%s\005{-}\n" "$(uname -r)"

Actually, writing it in tmux's way is ok.

Here is an example for showing the Wifi name with colors.

	#!/bin/sh -e
	COLOR_SET="#[fg=white bg=blue bold]"
	COLOR_RESTORE="#[fg=$BYOBU_LIGHT bg=$BYOBU_DARK]"
	out=`iwconfig $MONITORED_NETWORK 2>/dev/null | awk '$0 ~ /[ ]*SSID/ { sub(/.*[:]/,"",$4); printf("ssid=%s\n", $4); }'`
	eval "$out"
	if [ ! "$ssid" = "off/any" ]
	then
		echo -e "$COLOR_SET""$ssid""$COLOR_RESTORE"
	fi

