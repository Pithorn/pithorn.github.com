#!/bin/sh
pwd
ls
node_modules/hexo/bin/hexo generate
#git checkout public
#rm -rf css fancybox js index.html
#mv public/* .
#git add .
#git commit -m "[$(date)] auto-build"
#git push origin public
