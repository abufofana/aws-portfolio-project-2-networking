terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "project2_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "project2-vpc"
    Environment = "learning"
    Project     = "aws-portfolio-project-2"
  }


}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.project2_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "project2-public-subnet-1"
    Environment = "learning"
    Project     = "aws-portfolio-project-2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.project2_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name        = "project2-private-subnet-1"
    Environment = "learning"
    Project     = "aws-portfolio-project-2"
  }
}

resource "aws_internet_gateway" "project2_igw" {

  vpc_id = aws_vpc.project2_vpc.id

  tags = {
    Name        = "project2-igw"
    Environment = "learning"
    Project     = "aws-portfolio-project-2"
  }

}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.project2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project2_igw.id
  }

  tags = {
    Name        = "project2-public-rt"
    Environment = "learning"
    Project     = "aws-portfolio-project-2"
  }
}

resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_instance" "project2_web" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_subnet_1.id

  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name        = "project2-web-instance"
    Environment = "learning"
    Project     = "aws-portfolio-project-2"
  }
}

resource "aws_security_group" "ssh_access" {
  name        = "project2-ssh-access"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.project2_vpc.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "project2-ssh-access"
    Environment = "learning"
    Project     = "aws-portfolio-project-2"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name        = "project2-nat-eip"
    Environment = "learning"
    Project     = "aws-portfolio-project-2"
  }
}

resource "aws_nat_gateway" "project2_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name        = "project2-nat-gateway"
    Environment = "learning"
    Project     = "aws-portfolio-project-2"
  }

  depends_on = [aws_internet_gateway.project2_igw]
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.project2_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.project2_nat.id
  }

  tags = {
    Name        = "project2-private-rt"
    Environment = "learning"
    Project     = "aws-portfolio-project-2"
  }
}

resource "aws_route_table_association" "private_subnet_assoc" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}