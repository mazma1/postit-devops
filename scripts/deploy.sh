#!/usr/bin/env bash

# exit when a command fails
set -o errexit

# show all commands being executed
set -o xtrace

# exit if previous command returns a non 0 status
set -o pipefail 

declare_env_variables() {
  AMI_ID=""
  JENKINS_SERVER_IP="18.195.138.186"
}

download_unzip_build_artifact() {
  if [[ -f artifact.zip ]]; then
    sudo rm artifact.zip
  fi
  if [[ -d /home/jenkins/archive ]]; then
    sudo rm -rf /home/jenkins/archive
  fi
  sudo mkdir -p /home/jenkins
  sudo chmod -R 777 /home/jenkins
  wget --auth-no-challenge --http-user=admin --http-password=096730731dddf2559b0d7a2b1c60b870 http://18.195.138.186:8080/job/Build/lastSuccessfulBuild/artifact/\*zip\*/artifact.zip
  unzip artifact.zip -d /home/jenkins
}

create_packer_image() {
  cd /home/jenkins/archive/packer/app_image
  packer build template.json
  cd ~
}

provision_infrastructure() {
  cd /home/jenkins/archive/terraform
  terraform init -backend=true
  terraform plan  -var="aws_ami_id=${AMI_ID}" -var="aws_access_key=${AWS_ACCESS_KEY_ID}" -var="aws_secret_key=${AWS_SECRET_ACCESS_KEY}"
  terraform apply  -var="aws_ami_id=${AMI_ID}" -var="aws_access_key=${AWS_ACCESS_KEY_ID}" -var="aws_secret_key=${AWS_SECRET_ACCESS_KEY}" -auto-approve
}

deploy() {
  declare_env_variables
  download_unzip_build_artifact
  create_packer_image
  provision_infrastructure
}

deploy