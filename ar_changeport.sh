#!/bin/bash

user="root"
server="he_port"
remote_changeport_script="he_changeport.sh"

# get new port number as argument
current_port="$1"

MAX_RETRIES=5
RETRY_COUNT=0

while true; do
    # calling hetzner to change the port
    ssh -p $current_port $user@$server "bash $remote_changeport_script"
    if [ $? -eq 0 ]; then
        exit 0  # set exit status to 0 (success) and exit the script
    else
        RETRY_COUNT=$((RETRY_COUNT+1))
        if [ $RETRY_COUNT -ge $MAX_RETRIES ]; then
            echo "Max retries exceeded in Arvan"
            exit 1  # set exit status to 1 (failure) and exit the script
        fi
    fi
done
