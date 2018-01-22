#!/usr/bin/env bash

# script to install node on an instance

# exit when a command fails
set -o errexit

# show all commands being executed
set -o xtrace

# exit if previous command returns a non 0 status
set -o pipefail 

# update instance
update_system() {
  sudo apt-get update -y
  sudo apt-get upgrade -y
}

# install nvm
install_nvm() {
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
  export NVM_DIR="/home/ubuntu/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

# install node via nvm
install_node() {
  nvm install 6.11.2
}

# execute installation commands
install() {
  update_system
  install_nvm
  install_node
}

install
