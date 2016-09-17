#!/bin/sh
hexo generate
git checkout public
rm -r css fancybox js index.html db.json
mv public/* .
git push origin public
git add .
git commit -m "[$(date)] auto-build"
