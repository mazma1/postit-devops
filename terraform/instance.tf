resource "random_string" "tag" {
  length = 3
  special = false
}

provider "aws" {
  region     = "eu-central-1"
}

resource "aws_security_group" "demo" {
  name = "Terraform/Packer"
  description = "Terraform/Packer Demo"
  vpc_id = "${var.vpc_id}"

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
  ami = "${var.aws_ami_id}"
  instance_type = "t2.micro"
  key_name = "EssentialsKeyPair"
  subnet_id = "${var.subnet_id}"
  security_groups = [ "${aws_security_group.demo.id}" ]
  associate_public_ip_address = true
  tags {
    Name = "Demo App Server-${random_string.tag.result}"
  }
}

