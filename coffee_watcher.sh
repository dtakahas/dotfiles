#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

COFFEE_FOLDER="$SCRIPT_DIR/src"
JS_FOLDER="$SCRIPT_DIR/lib"

if which coffee > /dev/null; then
  coffee -w -c -o $JS_FOLDER $COFFEE_FOLDER
else
  echo "coffee command not found, please install it"
fi


