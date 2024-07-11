resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.aws_subnet_public_subnet1_cidr_block
  availability_zone       = var.availability_zone1
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.aws_subnet_public_subnet2_cidr_block
  availability_zone       = var.availability_zone2
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.aws_subnet_private_subnet1_cidr_block
  availability_zone       = var.availability_zone1
  map_public_ip_on_launch = false
}

resource "aws_subnet" "private_subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.aws_subnet_private_subnet2_cidr_block
  availability_zone       = var.availability_zone2
  map_public_ip_on_launch = false
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_eip" "eip1" {
  domain = "vpc"
}

resource "aws_eip" "eip2" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_public_subnet1" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.public_subnet1.id
}

resource "aws_nat_gateway" "nat_public_subnet2" {
  allocation_id = aws_eip.eip2.id
  subnet_id     = aws_subnet.public_subnet2.id
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "public_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}


resource "aws_route_table" "private1_to_nat" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_public_subnet1.id}"
  }
}

resource "aws_route_table" "private2_to_nat" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_public_subnet2.id}"
  }
}


resource "aws_route_table_association" "public1" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_subnet1.id
}

resource "aws_route_table_association" "public2" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_subnet2.id
}

resource "aws_route_table_association" "private1" {
  route_table_id = aws_route_table.private1_to_nat.id
  subnet_id      = aws_subnet.private_subnet1.id
}

resource "aws_route_table_association" "private2" {
  route_table_id = aws_route_table.private2_to_nat.id
  subnet_id      = aws_subnet.private_subnet2.id
}
