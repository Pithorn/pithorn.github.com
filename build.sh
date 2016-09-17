#!/bin/sh
hexo generate
git checkout public
mv public/* .
git push origin public
