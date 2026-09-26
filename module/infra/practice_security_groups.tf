resource "aws_security_group" "practice_alb_sg" {
  name        = "alb_sg"
  description = "Allow inbound traffic and outbound traffic to and from alb"
  vpc_id      = aws_vpc.practice_vpc.id

  ingress {
    to_port     = 80
    from_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment_name}-alb-sg"
    Environment = var.environment_name
  }
}

resource "aws_security_group" "practice_public_app_sg" {
  name        = "public_app_sg"
  description = "Allow inbound traffic and outbound traffic to and from the public app on port 22 for ssh"
  vpc_id      = aws_vpc.practice_vpc.id

  ingress {
    to_port     = 22
    from_port   = 22
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
    Name        = "${var.environment_name}-publc-app-sg"
    Environment = var.environment_name
  }
}

resource "aws_security_group" "practice_app_sg" {
  name        = "app_sg"
  description = "Allow inbound traffic and outbound traffic to and from the app"
  vpc_id      = aws_vpc.practice_vpc.id

  ingress {
    to_port         = 80
    from_port       = 80
    security_groups = [aws_security_group.practice_alb_sg.id]
    protocol        = "tcp"
  }

  ingress {
    to_port         = 22
    from_port       = 22
    security_groups = [aws_security_group.practice_public_app_sg.id]
    protocol        = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment_name}-app-sg"
    Environment = var.environment_name
  }
}