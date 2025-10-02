##!/bin/bash
function tmux_sessions() {
  tmux list-session -F '#S'
}

TMUX_SESSION=$( (
  echo new
  tmux_sessions
) | walker -d -p "Select tmux session")

if [[ x"new" = x"${TMUX_SESSION}" ]]; then
  echo "New session name:"
  new_name="$(printf '' | eval "walker -d -f  -p 'New session name:'" || true)"
  # remove white spaces from beginning and end
  new_name=$(echo "${new_name}" | sed 's/^[ \t]*//;s/[ \t]*$//')

  [ -n "$new_name" ] || exit 0

  echo "Create new session: ${new_name}"

  #  (~/scripts/utils/tmux-session.sh "-n $new_name" &)
  ~/scripts/utils/tmux-session.sh -n "$new_name"

elif [[ -z "${TMUX_SESSION}" ]]; then
  echo "Cancel"
else
  # remove white spaces from beginning and end
  TMUX_SESSION=$(echo "${TMUX_SESSION}" | sed 's/^[ \t]*//;s/[ \t]*$//')
  echo "Attach to <${TMUX_SESSION}>"
  ~/scripts/utils/tmux-session.sh -n "$TMUX_SESSION"

fi
