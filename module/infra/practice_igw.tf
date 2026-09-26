resource "aws_internet_gateway" "practice_igw" {
  vpc_id = aws_vpc.practice_vpc.id

  tags = {
    Name        = "${var.environment_name}-internet-gateway"
    Environment = var.environment_name
  }
}