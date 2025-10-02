#!/bin/bash

# Default values
SESSION_NAME=""
SESSION_DIR="$HOME"
TERMINAL="alacritty" # change to your terminal: kitty, foot, etc.

# Parse args
while getopts "n:d:" opt; do
  case $opt in
  n) SESSION_NAME="$OPTARG" ;;
  d) SESSION_DIR="$OPTARG" ;;
  *)
    echo "Usage: $0 -n <session_name> -d <directory>"
    exit 1
    ;;
  esac
done

if [ -z "$SESSION_NAME" ]; then
  echo "Error: session name is required (-n)"
  exit 1
fi

# Function: spawn terminal with tmux
spawn_terminal() {
  cd "$SESSION_DIR" || exit 1
  "$TERMINAL" -e tmux new-session -A -s "$SESSION_NAME" &
}

# Check if tmux session exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Session $SESSION_NAME exists. Checking for window..."

  # Find Hyprland window containing this tmux session
  WIN_ID=$(hyprctl clients -j | jq -r ".[] | select(.title | test(\"$SESSION_NAME\")) | .address" | head -n1)

  if [ -n "$WIN_ID" ]; then
    echo "Found window for $SESSION_NAME, focusing..."
    hyprctl dispatch focuswindow address:$WIN_ID
  else
    echo "No window found for session, spawning new terminal and attaching..."
    "$TERMINAL" -e tmux attach-session -t "$SESSION_NAME" &
  fi
else
  echo "Session $SESSION_NAME does not exist. Creating new one..."
  spawn_terminal
fi
