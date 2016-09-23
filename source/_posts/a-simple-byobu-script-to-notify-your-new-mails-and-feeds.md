title: "A colorful byobu script to notify your new mails and feeds"
date:  2015-01-09
tags: [linux,byobu,rssdrop,script]
---

After [delivering all the feeds to Maildirs by rssdrop](../../../../2014/12/29/using-rssdrop-to-read-feeds-in-mutt/), I also need a notification daemon in my byobu shell.

Byobu supports custom script and display the outputs in the bottom bar. And particularly, you can [use colors in byobu script's output](../../../../2014/11/11/show-colors-in-byobu-control-bar/)!
<!--more-->

![img](http://7sbplw.com1.z0.glb.clouddn.com/screenshot-20150109_155440.png)

Here is my notification script at `~/.byobu/bin/5_mail`. 5 means checking every 5 seconds. Byobu will force all the scripts those period is shorter than 5 seconds to run as 5.

```sh
#!/bin/sh -e
MAILDIR="/home/$USER/Mail/Yahoo/Inbox"
LOCK="/home/$USER/桌面/新邮件.desktop"
LOCKFILE="/home/$USER/.byobu/bin/新邮件.desktop"
MSGICON="/usr/share/icons/Faenza/apps/scalable/gmail.svg"
ICON_MAIL="[新邮件!]"
COLOR_SET="#[fg=red bg=white bold]"
COLOR_RESTORE="#[fg=$BYOBU_LIGHT bg=$BYOBU_DARK]"

if [ ! "`ls $MAILDIR/new`" = "" ] ; then
	echo "$COLOR_SET""$ICON_MAIL""$COLOR_RESTORE"
	if [ ! -f $LOCK ]; then
		cp $LOCKFILE $LOCK
		notify-send -i $MSGICON "新邮件" $ICON_MAIL
	fi
else
	rm -f $LOCK
fi

cd /home/$USER/Mail/rss/
for i in *
do
	if [ ! "`ls $i/new`" = "" ] ; then
		echo "$COLOR_SET""[$i]""$COLOR_RESTORE"
	fi
done
```
