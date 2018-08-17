#! /bin/bash
#@author sukianata
#@desc pushing some projects to github  automatically
#@param1 the path of the project
#@param2 the name of the project
echo ">>>>>begin>>>>>"
echo "The project path>>>>>>> $1"
echo "The project name>>>>>>> $2"
echo "the '/' will be replaced by '\' .... "
_r1="$1"
_r1="${_r1//\//\\/}"
cd "$_r1"
echo ">>>>>>entering $_r1"
echo "the current directory is $_r1"
echo ">>>init it as a git repository"
git init 
git config user.name 'sukianata'
git config user.email '2655716003@qq.com'
echo '>>>>>setting proxy'
git config http.proxy http://10.48.13.132:3128
git config https.proxy http://10.48.13.132:3128
echo "finished!using proxy : http://10.48.13.132:3128"
echo ">>>>>adding repo.........."
git remote add "$2"  https://github.com/sukianata/$2.git
echo ">>>>>finished!using repo:https://github.com/sukianata/$2.git"
echo ">>>>will ingore jar files "
echo -e "*.jar\r\n.settings/*\n.gitignore\n.gitkeep\n*.class">.gitignore
#keep the jars's directory
find . -name '*.jar'>temp.txt
echo ">>>>>reading temp data"
#reading temp.txt and create .gitkeep file
pp=""
for xx in `cat temp.txt`
do
	cc=${xx}
	aa="/"${xx##*\/}
	bb="${cc/${aa}/}"
	if [ "$pp" = "$bb" ] 
	then
		cd ${bb}
		echo -e ${xx##*\/}"\n">>jarList.txt	
		cd ..
	else
	   pp="${cc/${aa}/}"
	   cd ${bb}
	   var=`pwd`
	   echo ">>>>creating .gitkeep in $var"
	   touch .gitkeep
	   echo ">>>>creating jarList in $var"
	   echo  -e "jars are too big to upload for me ,so I list them. Some of them may be never used.\n">jarList.txt
	   echo  -e ${xx##*\/}"\n">>jarList.txt
	   cd ..
	fi
done
rm -f temp.txt
echo '>>>>>startting push to Github...'
git add .
git commit -m 'update  by sukianata'
echo '>>>>>pushing...'
git push "$2" master --force
rm  -rf .git
rm .gitignore
rm $(find . -name ".gitkeep")

echo '>>>>> Done!'



