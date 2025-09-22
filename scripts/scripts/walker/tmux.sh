##!/bin/bash
function tmux_sessions() {
  tmux list-session -F '#S'
}

TMUX_SESSION=$( (
  echo new
  tmux_sessions
) | walker -d -p "Select tmux session")

if [[ x"new" = x"${TMUX_SESSION}" ]]; then
  new_name="$(printf '' | eval "walker -d -f  -p 'New session name:'" || true)"
  [ -n "$new_name" ] || exit 0

  rofi-sensible-terminal -e tmux new-session -s "$new_name" &
elif [[ -z "${TMUX_SESSION}" ]]; then
  echo "Cancel"
else
  rofi-sensible-terminal -e tmux attach -t "${TMUX_SESSION}" &
fi
