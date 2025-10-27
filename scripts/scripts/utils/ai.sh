#!/usr/bin/env bash

# read first parameter as prompt
prompt="$1"

# check if prompt is empty
if [ -z "$prompt" ]; then
  echo "Please provide a prompt."
  exit 1
fi

# check if there is flags, like -m (model) or -a (agent)
while getopts "m:a:" opt; do
  case $opt in
  m) model="$OPTARG" ;;
  a) agent="$OPTARG" ;;
  *) echo "Invalid option: -$OPTARG" >&2 ;;
  esac
done

# send prompt to openai api
curl -X POST 'http://localhost:3001/prompts' \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
  "model": "gpt-4", 
  "prompt": "'"$prompt"'", 
  "temperature": "0.7" 
}'
