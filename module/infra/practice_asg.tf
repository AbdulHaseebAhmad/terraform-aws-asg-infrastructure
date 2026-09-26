resource "aws_autoscaling_group" "practice_asg" {
  name                      = "${var.environment_name}-practice-asg"
  max_size                  = var.asg_config.max_size
  min_size                  = var.asg_config.min_size
  health_check_grace_period = var.asg_config.health_check_grace_period
  health_check_type         = "ELB"
  desired_capacity          = var.asg_config.desired_capacity
  vpc_zone_identifier = [
    aws_subnet.private_subnet[0].id,
    aws_subnet.private_subnet[1].id
  ]
  target_group_arns = [aws_lb_target_group.practice_target_group.arn]
  launch_template {
    id      = aws_launch_template.practice_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Environment"
    value               = var.environment_name
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "${var.environment_name}-practice-asg"
    propagate_at_launch = true
  }
}