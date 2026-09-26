resource "aws_lb" "practice_lb" {
  name               = "${var.environment_name}-practice-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.practice_alb_sg.id]
  subnets            = [for subnet in aws_subnet.public_subnet : subnet.id]

  enable_deletion_protection = false

  tags = {
    Name        = "${var.environment_name}-practice-lb"
    Environment = var.environment_name
  }
}


 