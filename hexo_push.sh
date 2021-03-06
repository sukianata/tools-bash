#! /bin/bash
#@author sukianata
#@desc pushing hexo static files generated by hexo to github and coding automatically
echo 'startting...'
echo '>>>>>hexo generating files...'
cd /d/aHFdoc/blog/
hexo clean
hexo g
echo '>>>>>Finished!'
echo '>>>>>delete old files...'
rm -rf /d/aHFdoc/hexo/public/
echo '>>>>>Done!'
echo '>>>>>copy new files...'
mkdir /d/aHFdoc/hexo/public/
cp -r /d/aHFdoc/blog/public/* /d/aHFdoc/hexo/public/
echo '>>>>>rename folder names..'
cd /d/aHFdoc/hexo/public/
mv About/ about/
mv Categories/  categories/
mv Tags/  tags/
echo '>>>>>Done!'
echo '>>>>>start to push'
cd /d/aHFdoc/hexo/public/
#rm -rf .git
git init
git config user.name 'sukianata'
git config user.email '2655716003@qq.com'
echo '>>>>>startting push to Github...'
echo '>>>>>setting proxy'
git config http.proxy http://10.48.13.132:3128
git config https.proxy http://10.48.13.132:3128
echo '>>>>>add repo'
git remote add github https://github.com/sukianata/sukianata.github.io/
git fetch github
git checkout github/master README.md
git checkout github/master CNAME
git add .
git commit -m 'update hexo blog by sukianata'
echo '>>>>>pushing...'
git push github master -f
echo '>>>>>GitHub Done!'

echo '>>>>>startting push to Coding...'
echo '>>>>>setting proxy'
git config http.proxy http://10.195.248.120:3128
git config https.proxy http://10.195.248.120:3128
echo '>>>>>add repo'
git remote add coding https://git.coding.net/sukianata/sukianata.coding.me.git
git fetch coding
git checkout coding/master README.md
git add .
git commit -m 'update hexo blog by sukianata'
echo '>>>>>pushing...'
git push coding master -f
echo '>>>>>Coding Done!'
