#!/usr/bin/env bash

# this script generates a menu of markdown files in the ~/knowledge directory

md_dir=~/knowledge
md_files=("$md_dir"/*.md)

# create a httml div with links to the html files, make attention to escape the double quotes

echo "<div class='note-menu'>"

for file in "${md_files[@]}"; do
  filename=$(basename "$file" .md)
  #  echo "$filename"

  # create a html link to the html file
  link="file://$md_dir/output/$filename.html"
  echo "<div class='note-item'><a href='$link' target='_blank'>$filename</a></div>"

done

echo "</div>"

#done | rofi -dmenu -i -p "Open Note:" | xargs -I {} alacritty -e nvim "$md_dir/{}.md"
