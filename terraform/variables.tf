data "aws_ami" "app_ami" {
  most_recent = true
  filter {
    name = "name"
      values = ["app-*"]
  }
}

variable "vpc_id" {
  default = "vpc-3bd31850"
}

variable "subnet_id" {
    default = "subnet-3b825446"
} 


