#deploy.shの中身
#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

function gitRebuild(){
  printDir
  # Add changes to git.
  git add -A

  # Commit changes.
  msg="rebuilding site `date +"%Y/%m/%d %p %I:%M:%S"`"
  if [ $# -eq 1 ]
    then msg="$1"
  fi
  git commit -m "$msg"
  git push git@github.com:gc373/blog.git origin/master
}
function printDir(){
  printf "\033[0;31m[${PWD}]\033[0;39m\n"
}

# Build the project. 
rm -rf public/*
hugo
cd public
gitRebuild
# Come Back
cd ..