#!/bin/sh
hexo generate
git checkout public
mv public/* .
git add .
git commit -m "[$(date)] auto-build"
git push origin public
