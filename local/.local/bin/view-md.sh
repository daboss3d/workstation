#!/usr/bin/env bash

# check if pandock is installed, if not show error message and exit

if ! command -v pandoc &>/dev/null; then
  echo "pandoc could not be found, please install it first"
  exit
fi

# make sure there is a file and terminates with .md
#if [ -z "$1" ] || [[ "$1" != *.md ]]; then
# get name of the script
#  script_name=$(basename "$0")
#  script_name="${script_name%.*}"
#  echo "Usage: $script_name <file.md>"
#  exit
#fi

# defaults
DIR="/tmp/"
FILE=""

# parse arguments
while getopts "d:f:" opt; do
  case $opt in
  d) DIR="$OPTARG" ;;
  f) FILE="$OPTARG" ;;
  *)
    echo "Usage: $0 -f filename [-d directory]"
    exit 1
    ;;
  esac
done

# check if -f was provided
if [[ -z "$FILE" ]]; then
  echo "Error: -f (filename) is required"
  echo "Usage: $0 -f filename [-d directory]"
  exit 1
fi

echo "Directory: $DIR"
echo "File: $FILE"

# extract filename from path
#filename=$(basename -- "$1")
filename=$FILE
extension="${filename##*.}"
filename="${filename%.*}"

pandoc "$FILE" -o "$DIR/${filename}.html" --metadata title="$filename" --standalone --css pandoc.css

# copy style if not exists
# cp -n /home/daboss/knowledge/themes/pandoc/dark-pandoc.css /tmp/dark-pandoc.css
cp /home/daboss/knowledge/themes/pandoc/dark-pandoc.css /$DIR/pandoc.css

# launch viewer
omarchy-launch-webapp file:///$DIR/$filename.html
