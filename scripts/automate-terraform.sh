#!/usr/bin/env bash

# exit when a command fails
set -o errexit

# show all commands being executed
set -o xtrace

# exit if previous command returns a non 0 status
set -o pipefail 

cd ../terraform
terraform init
terraform plan
terraform apply