resource "aws_launch_template" "practice_public_launch_template" {
  name                                 = "${var.environment_name}-public-ec2-launch-template"
  image_id                             = "ami-0224ce6f9504665ee"
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t3.micro"
  key_name                             = "geos_bastion_server"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.practice_public_app_sg.id]


  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "${var.environment_name}-public-ec2-launch-template"
      Environment = var.environment_name
    }
  }
  user_data = filebase64("${path.module}/templates/user_data.tpl.sh")
}
