resource "aws_eip" "practice_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "practice_nat_gw" {
  allocation_id = aws_eip.practice_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name        = "${var.environment_name}-nat-gw"
    Environment = var.environment_name
  }
}