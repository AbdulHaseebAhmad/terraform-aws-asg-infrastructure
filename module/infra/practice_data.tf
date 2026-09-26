data "aws_instances" "asg_instances_private" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment_name}-practice-asg"]
  }
}
data "aws_instances" "asg_instances_public" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment_name}-practice-public-asg"]
  }
}

data "aws_instances" "public_ec2_ips" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment_name}-practice-public-asg"]
  }
}