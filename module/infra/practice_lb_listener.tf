resource "aws_lb_listener" "practice_lb_istener" {
  load_balancer_arn = aws_lb.practice_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.practice_target_group.arn
  }

  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-practice-lb-listener"
  }
}

