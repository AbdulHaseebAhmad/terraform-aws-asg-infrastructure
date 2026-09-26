resource "aws_autoscaling_policy" "practice_asg_policy" {
  autoscaling_group_name = aws_autoscaling_group.practice_asg.name
  name                   = "${var.environment_name}-practice-asg-policy"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60
  }
}

resource "aws_autoscaling_policy" "practice_public_asg_policy" {
  autoscaling_group_name = aws_autoscaling_group.practice_public_asg.name
  name                   = "${var.environment_name}-practice-public-asg-policy"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60
  }
}
