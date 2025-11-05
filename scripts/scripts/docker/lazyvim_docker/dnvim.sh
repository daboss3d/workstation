#!/usr/bin/env bash


CNT=mylazyvim

# check if container 'mylazyvim' is running
if [ "$(docker ps -q -f name=$CNT )" ]; then
    echo "Container '$CNT' is already running."
else
    # check if container 'mylazyvim' exists but is not running
    if [ "$(docker ps -aq -f name=$CNT)" ]; then
        echo "Starting existing container '$CNT'..."
        docker start $CNT
        docker attach $CNT
#    else
#        echo "Creating and starting new container 'mylazyvim'..."
#        docker run -d --name mylazyvim -v "$HOME/.config/nvim":/root/.config/nvim -v "$HOME/.local/share/nvim":/root/.local/share/nvim -v "$HOME/.cache/nvim":/root/.cache/nvim lazyvim/lazyvim:latest tail -f /dev/null
    fi
fi
