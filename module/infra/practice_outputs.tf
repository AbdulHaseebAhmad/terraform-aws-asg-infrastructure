output "practice_private_ec2_id" {
  description = "Outputs the EC2 instances ids"
  value       = data.aws_instances.asg_instances_private.ids
}

output "practice_public_ec2_id" {
  description = "Outputs the EC2 instances ids"
  value       = data.aws_instances.asg_instances_public.ids
}

output "practice_lb_name" {
  description = "outputs the ALB name"
  value       = aws_lb.practice_lb.name
}

output "practice_asg_name" {
  description = "outputs the ASG name"
  value       = aws_autoscaling_group.practice_asg.name
}

output "public_ec2s_ips" {
  description = "this will output the public ips of the public ec2S"
  value       = data.aws_instances.public_ec2_ips.public_ips
}