#!/usr/bin/env bash

# check if pandock is installed, if not show error message and exit
if ! command -v tmux &>/dev/null; then
  echo "tmux could not be found, please install it first"
  exit
fi

# defaults
DEFAULT_DIR="$HOME"

# one-liner which will give you the full directory name of the script no matter where it is being called from.
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

source $SCRIPT_DIR/read-parameters.sh
DIR=$(get_param -d "$@")
DIR=${DIR:-$DEFAULT_DIR}
echo "-d parameter is $DIR"
#exit

SESSION_NAME="codeing"
WINDOW_1="shell"
WINDOW_2="editor"

SESSION_EXISTS=$(tmux ls | grep -w $SESSION_NAME)

if [ -n "$SESSION_EXISTS" ]; then
  echo "Session $SESSION_NAME already exists. Attaching to it..."
  tmux attach-session -t $SESSION_NAME
  exit 0
fi

tmux new-session -d -s $SESSION_NAME -n $WINDOW_1
tmux send-keys -t $SESSION_NAME:$WINDOW_1 "cd $DIR" C-m
tmux send-keys -t $SESSION_NAME:$WINDOW_1 "clear" C-m
tmux split-window -h -t $SESSION_NAME:$WINDOW_1
tmux send-keys -t $SESSION_NAME:$WINDOW_1.1 "fastfetch" C-m

tmux send-keys -t $SESSION_NAME:$WINDOW_1.2 "cd $DIR" C-m

# Window 2 - editor
tmux new-window -t $SESSION_NAME -n $WINDOW_2
tmux send-keys -t $SESSION_NAME:$WINDOW_2 "cd $DIR" C-m

tmux select-window -t $SESSION_NAME:$WINDOW_1

tmux attach-session -t $SESSION_NAME
