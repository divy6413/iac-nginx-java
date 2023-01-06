resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "${var.env}-vpc",
    Env  = "${var.env}"
    Team = "${var.team}"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.env}-ig"
    Env  = "${var.env}"
    Team = "${var.team}"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.env}-public-subnet-${substr(var.availability_zone, length(var.availability_zone) - 1, 1)}"
    Env  = var.env
    Team = var.team
    AZ   = var.availability_zone
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.env}-private-subnet-${substr(var.availability_zone, length(var.availability_zone) - 1, 1)}"
    Env  = var.env
    Team = var.team
    AZ   = var.availability_zone
  }
}

resource "aws_subnet" "db-subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.db_cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.env}-private-db-subnet-${substr(var.availability_zone, length(var.availability_zone) - 1, 1)}"
    Env  = var.env
    Team = var.team
    AZ   = var.availability_zone
  }
}

resource "aws_eip" "nat-gateway-eip" {
  vpc              = true
  public_ipv4_pool = "amazon"
  tags = {
    Name = "${var.env}-nat-gateway-eip-${substr(var.availability_zone, length(var.availability_zone) - 1, 1)}"
    Env  = var.env
    Team = var.team
    AZ   = var.availability_zone
  }
}

resource "aws_nat_gateway" "nat-gateway" {
  connectivity_type = "public"
  subnet_id         = aws_subnet.public-subnet.id
  allocation_id     = aws_eip.nat-gateway-eip.id

  tags = {
    Name = "${var.env}-nat-gateway-${substr(var.availability_zone, length(var.availability_zone) - 1, 1)}"
    Env  = var.env
    Team = var.team
    AZ   = var.availability_zone
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.ig_id
  }

  tags = {
    Name = "${var.env}-public-route-table-${substr(var.availability_zone, length(var.availability_zone) - 1, 1)}"
    Env  = var.env
    Team = var.team
    AZ   = var.availability_zone
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    Name = "${var.env}-private-route-table-${substr(var.availability_zone, length(var.availability_zone) - 1, 1)}"
    Env  = var.env
    Team = var.team
    AZ   = var.availability_zone
  }
}

resource "aws_route_table" "private-db-route-table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    Name = "${var.env}-private-db-route-table-${substr(var.availability_zone, length(var.availability_zone) - 1, 1)}"
    Env  = var.env
    Team = var.team
    AZ   = var.availability_zone
  }
}

resource "aws_route_table_association" "public-route-table-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-route-table-association" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-db-route-table-association" {
  subnet_id      = aws_subnet.db-subnet.id
  route_table_id = aws_route_table.private-db-route-table.id
}