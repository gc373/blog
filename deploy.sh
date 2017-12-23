#deploy.shの中身
#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

function gitUpdate() {
  # Add changes to git.
  git add -A

  # Commit changes.
  msg="update `date +"%Y/%m/%d %p %I:%M:%S"`"
  if [ $# -eq 1 ]
    then msg="$1"
  fi
  git commit -m "$msg"

  #Push source and build repos.
  git push origin master
}

function gitRebuild(){
  # Add changes to git.
  git add -A

  # Commit changes.
  msg="rebuilding site `date +"%Y/%m/%d %p %I:%M:%S"`"
  if [ $# -eq 1 ]
    then msg="$1"
  fi
  git commit -m "$msg"
}

# Build the project. 
hugo && gitUpdate
# Go To Public folder
cd public && gitRebuild && git push origin master
# Come Back
cd ..