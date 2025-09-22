#!/usr/bin/env bash

INDIR=~/knowledge/
OUTDIR=~/knowledge/output/
CSSFILE=~/knowledge/themes/pandoc/dark-pandoc.css

echo "Generating HTML files from markdown in $INDIR to $OUTDIR"

FIND_CMD="find $INDIR -type f -name '*.md'"

for FILE in $(eval $FIND_CMD); do
  REL_PATH="${FILE#$INDIR/}"
  OUT_PATH="$OUTDIR/${REL_PATH%.md}.html"
  OUT_DIR="$(dirname "$OUT_PATH")"

  FILENAME=$(basename "$FILE" .md)

  OUT_PATH="$OUTDIR/$FILENAME.html"

  mkdir -p "$OUT_DIR"

  echo "Converting $FILE to $OUT_PATH"
  pandoc "$FILE" -o "$OUT_PATH" --css "$CSSFILE" --metadata title="${FILENAME}" --standalone
done

cp "$CSSFILE" "$OUTDIR/"

# copy images directory if it exists
cp -r "$INDIR/images" "$OUTDIR/"

# copy static assets (if any) e.g., images
#find "$INDIR" -type f ! -name '*.md' | while read -r ASSET; do
#  REL_PATH="${ASSET#$INDIR/}"
#  DEST_PATH="$OUTDIR/$REL_PATH"
#  DEST_DIR="$(dirname "$DEST_PATH")"
#
#  mkdir -p "$DEST_DIR"
#  echo "Copying asset $ASSET to $DEST_PATH"
#  cp "$ASSET" "$DEST_PATH"
#done
