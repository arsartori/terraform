# Provider Block
provider "aws" {
  region = "us-east-1"
  profile = "devuser"
}

# Create VPC
resource "aws_vpc" "tfbookvpc" {
  cidr_block = "172.30.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "book-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "tfbookigw" {
  vpc_id = aws_vpc.tfbookvpc.id
  tags = {
    description = "Allows connection to internet"
  }
  depends_on = [ 
    aws_vpc.tfbookvpc 
  ]
}

# Create a Routing Table
resource "aws_route_table" "tfbookrt" {
  vpc_id = aws_vpc.tfbookvpc.id
  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tfbookigw.id
  }
  tags = {
    "description" = "Route table for inbound"
  }
  depends_on = [ aws_internet_gateway.tfbookigw ]
}

# Create a Subnet in VPC
resource "aws_subnet" "tfbooksub" {
  vpc_id = aws_vpc.tfbookvpc.id
  availability_zone = "us-east-1a"
  cidr_block = "172.30.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "tfbookvpcsub"
  }
  depends_on = [ aws_vpc.tfbookvpc ]
}

# Route table and subnet association
resource "aws_route_table_association" "tfbookrwset" {
  subnet_id = aws_subnet.tfbooksub.id
  route_table_id = aws_route_table.tfbookrt.id
  depends_on = [ 
    aws_subnet.tfbooksub,
    aws_route_table.tfbookrt ]
}

