##!/bin/bash
#myterminal="${TERMINAL}" # it would be better if this pulled from the omarchy $terminal
#myshell=zsh
#
#TMUX_BIN="$(command -v tmux || {
#  echo 'tmux not found'
#  exit 1
#})"
#
#terminal="${TERMINAL}"
#
#rofi_pick_session() {
#  rofi -dmenu -i -p 'tmux sessions:' -lines 10 \
#    -kb-row-down "Down,Control+n,j" -kb-row-up "Up,Control+p,k"
#}
#switch_to() {
#  if [[ -z "${TMUX-}" ]]; then
#    # Outside tmux, spawn new terminal running tmux attach
#    alacritty -e tmux attach-session -t "$1" &
#
#  else
#    # Inside tmux, just switch client
#    tmux switch-client -t "$1" &
#  fi
#}
## List existing sessions (just names)
#sessions="$("$TMUX_BIN" list-sessions -F '#{session_name}' 2>/dev/null || true)"
#
## Add a "create new" entry at the top
#menu="Create new session…\n$sessions"
#
#choice=$(printf '%b' "$menu" | rofi -dmenu -i -p "tmux session")
#[ -n "$choice" ] || exit 0
#
#switch_to "$chosen"

function tmux_sessions() {
  tmux list-session -F '#S'
}

TMUX_SESSION=$( (
  echo new
  tmux_sessions
) | rofi -dmenu -p "Select tmux session")

if [[ x"new" = x"${TMUX_SESSION}" ]]; then
  new_name="$(printf '' | eval "rofi -dmenu -i -l 0  -p 'New session name:'" || true)"
  [ -n "$new_name" ] || exit 0

  rofi-sensible-terminal -e tmux new-session -s "$new_name" &
elif [[ -z "${TMUX_SESSION}" ]]; then
  echo "Cancel"
else
  rofi-sensible-terminal -e tmux attach -t "${TMUX_SESSION}" &
fi
