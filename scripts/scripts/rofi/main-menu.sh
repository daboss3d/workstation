#!/bin/bash
myterminal="${TERMINAL}" # it would be better if this pulled from the omarchy $terminal
myshell=zsh
#  if [ $(hyprctl activewindow | rg 'class' | awk '{print $2}') == "$myterminal" ]; then
#
#   pid=$(hyprctl activewindow | rg 'pid' | awk '{print $2}')
#   # echo $processName > ~/debugtermcommand.txt
#   # echo $pid >> ~/debugtermcommand.txt
#   # echo $(pgrep -P $pid) >> ~/debugtermcommand.txt
#   # echo $(ps $pid) >> ~/debugtermcommand.txt
#   for word in $(pgrep -P $pid); do
#     # echo "ps words are $(ps $word)" >> ~/debugtermcommand.txt
#     if [[ "$(ps $word)" == *$myshell* ]]; then
#       # echo "zsh pid is: $word" >> ~/debugtermcommand.txt
#       # echo "zsh wd is: $(readlink /proc/$word/cwd)" >> ~/debugtermcommand.txt
#       uwsm app -- $myterminal $(readlink /proc/$word/cwd) &
#       # echo $(readlink /proc/$word/cwd)
#       exit 0
#     fi
#   done
# fi
#
# #default case
# uwsm app -- $myterminal ~ &
#
# uwsm app -- $myterminal -e ls ~ &

# uwsm app -- $myterminal -e $(ls ~ | rofi -dmenu) &
#
#myList=$myterminal -e $(ls ~)
#uwsm app -- $myterminal -e> /dev/null 2>&1 /dev/null 2>&1

# uwsm app -- $($myterminal -e ls ~ | rofi -demenu >/dev/null 2>&1) &
#
#
echo "hello\ntest\n" | $(rofi -demenu -async-pre-read 10 >/dev/null 2>&1)
