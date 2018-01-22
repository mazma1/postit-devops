#!/usr/bin/env bash

# script to install and start Jenkins

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

# add Jenkins repository key to the system
add_key() {
  wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
}

# append the Debian package repository address to the server's sources.list
append_repo() {
  echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
}

# install Jenkins
install_jenkins() {
  sudo apt-get update -y
  sudo apt-get install jenkins -y
}

# start Jenkins
start_jenkins() {
  sudo systemctl start jenkins
}

# execute configuration commands
configure() {
    update_system
    add_key
    append_repo
    install_jenkins
    start_jenkins
}

configure
