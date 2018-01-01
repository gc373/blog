#deploy.shの中身
#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

function printDir(){
  printf "\033[0;31m[${PWD}]\033[0;39m\n"
}
function gitRebuild(){
  printDir
  # Add changes to git.
  git add .

  # Commit changes.
  msg="rebuilding site `date +"%Y/%m/%d %p %I:%M:%S"`"
  if [ $# -eq 1 ]
    then msg="$1"
  fi
  printf "\033[0;31m[$msg]\033[0;39m\n"
  git commit -m "$msg"
  git push ssh://git@github.com:gc373/blog.git origin/master
}

# Build the project. 
cd public
git reset origin/master
cd ../
hugo
cd public
gitRebuild
# Come Back
cd ..