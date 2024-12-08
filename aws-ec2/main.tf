terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "^> 4.16"
    }
  }
  required_version = ">= 1.2.8"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami = "ami-05fa00d4c63e32376"
  instance_type = "t2.micro"
  tags = {
    Name = "DEVSRV"
  }
}