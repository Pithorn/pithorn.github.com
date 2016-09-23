title: "A simple bat script to splicing videos"
date: 2015-01-23
tags: [ffmpeg,windows,bat,script]
---
Well, actually it's a task given by my uncle. So the spirit of this script should be KISS, "Keep It Simple, Stupid".

Instead of GUI, I choose ffmpeg to be the decoder(and the encoder if necessary). Luckily, ffmpeg has a [static windows binary build](http://ffmpeg.zeranoe.com/builds/). A good start!
<!--more-->
The next part is writing a KISS script for windows. Because I'm not familiar to bat files at all, it took a while before I finally found out a trick to solve a problem about processing the files' name.

The final version of the script looks like the following:

```bat
@echo off
cd /d %~dp0
set ffmpeg=bin\ffmpeg.exe
del filelist.txt
del splicing.mkv
:LOOP
IF [%1]==[] GOTO END
	set filename=%1
	echo file ^'%~1^' >>filelist.txt 
	SHIFT
GOTO LOOP
:END
%ffmpeg% -f concat -i filelist.txt -c copy splicing.mkv
rename splicing.mkv spliced.mkv
del filelist.txt
```

The trick is using `%~1` to remove the `"` around the strings with spaces. Then force adding `'` around all the filenames or else the `\` will be escaped.

The usage of this script is quite simple. Make sure `bin\ffmpeg.exe` exist then drag all the videos to the script file.  
By default, it will not recode the videos to increase efficiency. If it goes wrong, such as splicing videos with different sizes, or the videos need to recode, just edit the ffmpeg command to fix it.
