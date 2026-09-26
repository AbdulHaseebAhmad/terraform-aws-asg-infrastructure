resource "aws_subnet" "private_subnet" {
  count             = length(var.private_cidrs)
  vpc_id            = aws_vpc.practice_vpc.id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.environment_name}-private-subnet-${count.index}"
    Environment = var.environment_name
  }
}

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_cidrs)
  vpc_id            = aws_vpc.practice_vpc.id
  cidr_block        = var.public_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.environment_name}-public-subnet-${count.index}"
    Environment = var.environment_name
  }
}


