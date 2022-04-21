#!/bin/zsh
echo EXECUTED FROM THIS FOLDER $(pwd)
echo removing double empty lines inside the file $1
sed -i '' '$!N; /^\(.*\)\n\1$/!P; D' $1