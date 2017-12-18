#!/bin/bash
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
