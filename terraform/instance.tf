provider "aws" {
  # access_key = "${var.env.AWS_ACCESS_KEY_ID}"
  # secret_key = "${var.env.AWS_SECRET_ACCESS_KEY}"
  region     = "${var.region}"
}

resource "random_string" "tag" {
  length = 6
  special = false
}

resource "aws_security_group" "demo" {
  name = "Terraform/Packer - ${random_string.tag.result}"
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
  provisioner "file" {
    source      = "/home/jenkins/archive/scripts/start-app.sh"
    destination = "/tmp/start-app.sh"

    connection {
      type     = "ssh"
      user     = "ubuntu"
      agent    = false
      private_key = "${file("/home/ubuntu/config/EssentialsKeyPair.pem")}"
    }
  }
  provisioner "remote-exec" {
    inline = [
      # "ssh -i 'EssentialsKeyPair.pem' ubuntu@${aws_instance.app.public_ip}",
      "sudo chmod +x /tmp/start-app.sh"
    ]
  }
}

# resource "aws_s3_bucket" "terraform-state-storage" {
#     bucket = "postit-terraform-state-storage"
 
#     versioning {
#       enabled = true
#     }
 
#     lifecycle {
#       prevent_destroy = true
#     }
 
#     tags {
#       Name = "Terraform State Store"
#     }      
# }


