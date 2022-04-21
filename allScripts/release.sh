#!/bin/zsh
start=`date +%s`
groupId=com.example
echo EXECUTED FROM THIS FOLDER $(pwd)

function gitCommitAndPush(){
    myGitCommit
    git push origin $(git branch --show-current)
}

function myGitCommit(){
    git add -A
    git commit -m $message
}

function findParentPom(){
folder=$1
pomFile=$(find $folder -maxdepth 1 -type f -name "pom.xml")
if [[ $pomFile != *pom.xml ]] # * is used for pattern matching
then
  while [[ $pomFile != *pom.xml ]] ; do
    folder=$(dirname $folder)
    pomFile=$(find $folder -maxdepth 1 -type f -name "pom.xml")
  done
fi

echo $pomFile
}

function perform {
  while read data; do
    findParentPom $data
  done
}

function allModifiedFiles(){
  {
  git diff main...$(git branch --show-current) --name-only   
  } | sort | uniq
}

function findParentPomOfModifiedFiles(){
  allModifiedFiles | awk -v pwd=$(pwd)/ '{print pwd$1}' | perform | sort | uniq
}

function findModifiedProjects(){
    while read pomFile; do
      pwd=$(pwd)
      pwdSize=$((${#pwd}+2))
      fullPomSize=${#pomFile}
      end=$(($fullPomSize-8))
      result=$( cut -c $pwdSize-$end <<< $pomFile)
      if [ -z "$result" ]
      then
            echo .
      else
            echo $result
      fi
    done
}

function mvnSetVersion(){
  mvn --quiet --batch-mode --offline org.codehaus.mojo:versions-maven-plugin:2.8.1:set -DprocessAllModules=false -DgenerateBackupPoms=false -DprocessParent=false -DupdateMatchingVersions=false $@
}

function mvnSetVersionToRelease(){
  mvnSetVersion -DremoveSnapshot $@
}

function mvnSetVersionToSnapshot(){
  mvnSetVersion -DnextSnapshot=true $@
}

function mvnSetVersionToReleaseIfSnapshot(){
  artifactPackingVersion=$(mvn --quiet --batch-mode $@ -DforceStdout help:evaluate -Dexpression='project.groupId}:${project.artifactId}:${project.packaging}:${project.version'  )
  if [[ $artifactPackingVersion == *SNAPSHOT ]]
  then
      if [[ $artifactPackingVersion == *pom* ]]
      then
        echo UPDATING VERSION OF A POM PROJECT SO WE ALSO CHANGE SO CHILDREN
        mvn --quiet --batch-mode --offline org.codehaus.mojo:versions-maven-plugin:2.8.1:set -DprocessAllModules=false -DgenerateBackupPoms=false -DprocessParent=true -DupdateMatchingVersions=false -DremoveSnapshot $@
      else
        echo changin $artifactPackingVersion to RELEASE FOR $@
        mvnSetVersionToRelease $@
      fi

  fi
}

function mvnUpdateExampleVersions(){
  mvn --offline --quiet org.codehaus.mojo:versions-maven-plugin:2.8.1:update-properties -DallowSnapshots=false -DgenerateBackupPoms=false -DprocessParent=true -DexcludeReactor=false -Dincludes=$groupId\*:\*
  mvn --offline --quiet org.codehaus.mojo:versions-maven-plugin:2.8.1:use-latest-versions -DallowSnapshots=false -DgenerateBackupPoms=false -DprocessParent=true -DexcludeReactor=false -Dincludes=$groupId\*:\*
}

function listOfModifiedProjects(){
  findParentPomOfModifiedFiles | findModifiedProjects | tr '\n' ','
}

function setVersionToReleaseOneByOne(){
    savedIFS=$IFS
    IFS=','     # hyphen (-) is set as delimiter
    read -rA projectList <<< "$1"   # str is read into an array as tokens separated by IFS
    for project in "${projectList[@]}"; do   # access each element of array
        if [ ! -z "$project" ]
        then
            mvnSetVersionToReleaseIfSnapshot --projects $project &
        fi
        wait
    done
    IFS=$savedIFS     # reset to default value after usage
}


function doIt(){
  echo begin
  savedListOfModifiedProject=$(listOfModifiedProjects)
  echo here is the list of projecst $savedListOfModifiedProject

  if [ -z "$savedListOfModifiedProject" ]
  then
    echo nothing to do: nothing has been modified
  else
    setVersionToReleaseOneByOne $savedListOfModifiedProject
    echo updating example versions
    mvnUpdateExampleVersions
    echo updating example versions DONE
    newListOfModifiedProject=$(listOfModifiedProjects)
    if [[ $newListOfModifiedProject != $savedListOfModifiedProject ]]
    then
      echo modif FIRST : $savedListOfModifiedProject  ------------- $newListOfModifiedProject
      doIt
    else
      echo building only the librairies without executing any tests $savedListOfModifiedProject
      mvn --quiet --batch-mode --projects $savedListOfModifiedProject clean install -DUT.skip=true -DIT.skip=true
      echo updating example versions 2
      mvnUpdateExampleVersions
      echo updating example versions 2 DONE
      newListOfModifiedProject2=$(listOfModifiedProjects)
      if [[ $newListOfModifiedProject2 != $savedListOfModifiedProject ]]
      then
        echo modif SECOND : $savedListOfModifiedProject  ------------- $newListOfModifiedProject2
        doIt
      else
        echo BUILDING THE WHOLE THING TO FINISH $newListOfModifiedProject2
        docker kill $(docker ps -q)
        docker rm $(docker ps -a -q)
        mvn  --quiet --batch-mode --projects $newListOfModifiedProject2 clean install && myGitCommit
      fi
    fi
  fi
}

currentBranch=$(git branch --show-current)
if [[ $currentBranch == master || $currentBranch == main ]]
then
  echo you current branch is $currentBranch we will not change anything on this branch
else
  echo $(allModifiedFiles)
  if [ -z "$(allModifiedFiles)" ]
  then
    echo nothing changed
  else
    echo please use enter to keep going: the message will be 'RELEASE'
    read message    
    message='RELEASE'
    doIt
  fi
fi







end=`date +%s`
echo it took $((end-start)) seconds