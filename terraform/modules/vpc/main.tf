resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "#{var.project_name}-vpc"
  }
}

resource "aws_subnet" "public" {
  count = 2 
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)
  vpc_id = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone = element(var.availability_zone, count.index)
  tags = {
    Name = "${var.project_name}-public-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = 2
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index+2)
  vpc_id = aws_vpc.vpc.id
  availability_zone = element(var.availability_zone, count.index)
  tags = {
    Name = "${var.project_name}-private-${count.index}"
  }
}