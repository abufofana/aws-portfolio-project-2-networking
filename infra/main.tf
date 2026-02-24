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