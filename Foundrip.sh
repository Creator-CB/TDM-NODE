#!/bin/bash

set -e

apt-get update && sudo apt-get upgrade -y

apt-get install curl jq -y

max_retries=3
retry_delay=10
retries=0
while [ $retries -lt $max_retries ]; do
    if curl -L https://foundry.paradigm.xyz | bash; then
        echo "Foundry installation successful."
        break
    else
        echo "Failed to install Foundry. Retrying in $retry_delay seconds..."
        sleep $retry_delay
        retries=$((retries+1))
    fi
done

if [ $retries -eq $max_retries ]; then
    echo "Error: Failed to install Foundry after $max_retries attempts."
    exit 1
fi
