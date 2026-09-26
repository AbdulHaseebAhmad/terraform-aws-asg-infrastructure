resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.practice_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.practice_igw.id
  }


  tags = {
    Name        = "${var.environment_name}-public-route-table"
    Environment = var.environment_name
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  count          = length(var.public_cidrs)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.practice_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.practice_nat_gw.id
  }

  tags = {
    Name        = "${var.environment_name}-private-route-table"
    Environment = var.environment_name
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  count          = length(var.public_cidrs)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}