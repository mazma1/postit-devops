#!/usr/bin/env bash

# exit when a command fails
set -o errexit

# show all commands being executed
set -o xtrace

# exit if previous command returns a non 0 status
set -o pipefail

sudo apt-get update -y
sudo cd /home/ubuntu/post-it
sudo npm install
sudo npm start