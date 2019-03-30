#!/bin/bash
#deploy.shの中身

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

function printDir(){
  printf "\033[0;31m[${PWD}]\033[0;39m\n"
}
function gitRebuild(){
  printDir
  # Add changes to git.
  git add -A

  # Commit changes.
  now=`date +"%Y/%m/%d %H:%M:%S"`
  msg=":tada: rebuilding site ${now} :tada:"
  printf "\033[0;31m[${msg}]\033[0;39m\n"
  if [ $# -eq 1 ]
    then msg="$1"
  fi
  printf "\033[0;31m[:tada:${now}:tada:]\033[0;39m\n"
  git commit -m "$msg"
  git push origin master
}

# Build the project. 
rm -rf public/
git submodule sync
git submodule update --init --recursive
git clone git@github.com:gc373/blog.git public
cd public
git config --global user.name "${GIT_USER_NAME}"
git config --global user.email "${GIT_USER_EMAIL}"
git reset origin/master
cd ../
hugo
cd public
gitRebuild