#!/usr/bin/env bash

# script to install node on an instance

# exit when a command fails
set -o errexit

# show all commands being executed
set -o xtrace

# exit if previous command returns a non 0 status
set -o pipefail 

sudo mkdir -p /home/ubuntu/app,
sudo chmod -R 777 /home/ubuntu/app
if [[ -d /home/ubuntu/app ]]; then
  echo '=======> Directory exists'
fi