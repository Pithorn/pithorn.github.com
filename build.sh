#!/bin/sh
hexo generate
git checkout public
mv public/* .
git push origin public
git add .
git commit -m "[$(date)] auto-build"
