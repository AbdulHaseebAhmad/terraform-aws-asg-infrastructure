resource "aws_lb_target_group" "practice_target_group" {
  name        = "${var.environment_name}-lb-tg"
  target_type = "instance"

  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.practice_vpc.id

  health_check {
    path     = "/"
    protocol = "HTTP"
  }

  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-practice-lb-target-group"
  }
}

