#!/usr/bin/env bash

# print all script parameters
ALL_PARAMS="$@"

echo "All parameters: $ALL_PARAMS"

# function to get the value of a flag
get_param() {
  local flag="$1"
  shift
  while [[ $# -gt 0 ]]; do
    if [[ "$1" == "$flag" ]]; then
      echo "$2"
      return 0
    fi
    shift
  done
  return 1
}
