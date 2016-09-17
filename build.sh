#!/bin/sh
hexo generate
git checkout public
mv public/* .
