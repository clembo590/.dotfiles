#!/bin/zsh
start=`date +%s`

echo EXECUTED FROM THIS FOLDER $(pwd)

currentBranch=$(git branch --show-current)
if [[ $currentBranch == master || $currentBranch == main ]]
then
  echo you current branch is $currentBranch we will not change anything on this branch
else
  echo committing; git add -A && git commit -m "auto commit" && git push origin $(git branch --show-current)
  echo branh has been pushed
fi


end=`date +%s`
echo it took $((end-start)) seconds