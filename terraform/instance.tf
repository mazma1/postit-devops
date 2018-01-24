provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-central-1"
}

resource "random_string" "tag" {
  length = 6
  special = false
}

resource "aws_security_group" "demo" {
  name = "Terraform/Packer"
  description = "Terraform/Packer Demo"
  vpc_id = "${var.vpc_id}"
  lifecycle {
    create_before_destroy = true
  }

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      }

  ingress {
      from_port = 3000
      to_port = 3000
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      }

   }

resource "aws_instance" "app" {
  ami = "${data.aws_ami.app_ami.id}"
  instance_type = "t2.micro"
  key_name = "EssentialsKeyPair"
  subnet_id = "${var.subnet_id}"
  security_groups = [ "${aws_security_group.demo.id}" ]
  associate_public_ip_address = true
  tags {
    Name = "Demo App Server - ${random_string.tag.result}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket" "terraform-state-storage" {
    bucket = "terraform-state-storage"
 
    versioning {
      enabled = true
    }
 
    lifecycle {
      prevent_destroy = true
    }
 
    tags {
      Name = "Terraform State Store"
    }      
}

