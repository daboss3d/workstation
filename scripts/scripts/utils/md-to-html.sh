#!/usr/bin/env bash

# check if pandock is installed, if not show error message and exit
if ! command -v pandoc &>/dev/null; then
  echo "pandoc could not be found, please install it first"
  exit
fi

print_how_to() {
  echo "Usage: $0 -f <file>"
  echo "  -f <file> : file to convert to html"
  echo "  -d <dir>  : output directory (optional)"
  echo "  -h        : show this help message"
  echo "if -d output directory is not specified, it will default to same directory as the input file"
}

# defaults
DEFAULT_DIR="$HOME"

# one-liner which will give you the full directory name of the script no matter where it is being called from.
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

source $SCRIPT_DIR/read-parameters.sh
FILE=$(get_param -f "$@")
# if file doesn't exit print help message
if [ -z "$FILE" ]; then
  print_how_to
  exit 1
fi
# check if file exists
if [ ! -f "$FILE" ]; then
  echo "File <$FILE> does not exist"
  exit 1
fi

# if filename is not ending with .md print error message and exit
if [[ "$FILE" != *.md ]]; then
  echo "File <$FILE> is not a valid markdown file"
  exit 1
fi
OUTDIR=$(get_param -d "$@")
if [ -z "$OUTDIR" ]; then
  OUTDIR=$(dirname "$FILE")
fi

CSSFILE=~/knowledge/themes/pandoc/dark-pandoc.css
TEMPLATEDIR=/home/daboss/knowledge/templates
FILENAME=$(basename "$FILE" .md)

echo "Converting MD file <$FILE> to $OUTDIR/$FILENAME.html"

# copy css file to output directory
c

pandoc "$FILE" \
  -o "$OUTDIR/$FILENAME.html" \
  --css "$CSSFILE" \
  --metadata title="${FILENAME}" \
  --standalone \
  -M mdpath="$(realpath "$FILE")" \
  --variable dab_menu="$(</$OUTDIR/dab_menu.html)" \
  --template="$TEMPLATEDIR/"edit-file.html
