#!/bin/bash

git branch > /dev/null 2>&1

if [ "$?" == "0" ]; then
echo "Searching git repository"
  git grep "$@"
else
echo "Searching all files and subfolders"
  grep -r "$@" *
fi