terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.10.0"
      }
  }
}

provider "aws" {
  profile = "devuser"
  region = "us-east-1"
}

resource "aws_vpc" "stag" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Nome = "Sumit_Demo_vpc"
  }
}

resource "aws_internet_gateway" "int_gw" {
  vpc_id = aws_vpc.stag.id

  tags = {
    value = "Internet_Stage_GW"
  }
}

