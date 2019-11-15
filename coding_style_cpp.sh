####################################################################
# Author: 
# Version: 1.0
# Description: This script enables a user to reformat certain elements 
#	       of a C++ source code. 
# 	       This helps if one person's code is a little unreadable, 
#              or has been indented to  a  style  that you  dislike.
# Usage: $ coding_style_cpp <path_to_project_name>
####################################################################

#!/bin/bash

if [ $# -eq 0 ]
then
    echo "No project name"
    echo "$ coding_style_cpp <path_to_project_name>"
    exit 1
fi

if ! [ -x "$(command -v bcpp)" ]; then
  echo 'Error: bcpp is not installed.' >&2
  echo "Debian: sudo apt install bcpp"
  exit 1
fi

PROJECT_DIR=$1
COUNTER=0

find $PROJECT_DIR -type f -name "*.cpp" > files.txt

while IFS= read -r line
do
  echo "$line"
  bcpp -fi $line -f 2 -qb 5 -na -no > $line_$COUNTER
  rm -rf $line
  mv $line_$COUNTER $line
  rm -rf $line_$COUNTER
  COUNTER=$((COUNTER+1))
done < files.txt

rm -rf files.txt
