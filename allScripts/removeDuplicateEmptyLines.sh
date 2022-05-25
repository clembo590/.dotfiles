#!/bin/zsh
echo EXECUTED FROM THIS FOLDER $(pwd)
echo removing double empty lines inside the files $@
sed -i '' '$!N; /^\(.*\)\n\1$/!P; D' $@