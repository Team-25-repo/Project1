terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

}
provider "aws" {
  region = "us-east-1"
  #shared_config_files      = ["/Users/tf_user/.aws/conf"]
  shared_credentials_files = ["/Users/mfonu/.aws/credentials"]
  profile                  = "mfoncharis"
}

# Create a VPC
resource "aws_vpc" "Team25_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "Team25"
  }
}

# Create a subnet
resource "aws_subnet" "team25_subnet" {
  vpc_id                  = aws_vpc.Team25_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "team25-subnet"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "team25_igw" {
  vpc_id = aws_vpc.Team25_vpc.id
  tags = {
    Name = "team25-internet-gateway"
  }
}

# Create a route table
resource "aws_route_table" "team25_route_table" {
  vpc_id = aws_vpc.Team25_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.team25_igw.id
  }
  tags = {
    Name = "team25-route-table"
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "team25_route_table_association" {
  subnet_id      = aws_subnet.team25_subnet.id
  route_table_id = aws_route_table.team25_route_table.id
}

# Create a security group
resource "aws_security_group" "team25_security_group" {
  name        = "team25-security-group"
  description = "Allow all inbound traffic and HTTP/HTTPS outbound traffic"
  vpc_id      = aws_vpc.Team25_vpc.id

  # Allow all inbound traffic from any IP address
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # Allow all protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow from any IP address
  }

  # Allow outbound traffic on all ports and protocols
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # Allow all protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow to any IP address
  }
}

# Create an EC2 instance
resource "aws_instance" "team25_instance" {
  ami                    = "ami-007855ac798b5175e" # Amazon Linux 2023 AMI
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.team25_subnet.id
  vpc_security_group_ids = [aws_security_group.team25_security_group.id]
  tags = {
    Name = "team25-instance"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo yum -y update
              sudo yum -y install httpd
              sudo systemctl enable httpd
              sudo systemctl start httpd
              EOF
}

# Output the public IP address of the EC2 instance
output "instance_public_ip" {
  value       = aws_instance.team25_instance.public_ip
  description = "The public IP address of the EC2 instance"
}


