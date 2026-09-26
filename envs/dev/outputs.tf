output "practice_private_ec2_id" {
  description = "Outputs the EC2 instances ids"
  value       = module.infra.practice_private_ec2_id
}

output "practice_public_ec2_id" {
  description = "Outputs the EC2 instances ids"
  value       = module.infra.practice_public_ec2_id
}

output "practice_lb_name" {
  description = "outputs the ALB name"
  value       = module.infra.practice_lb_name
}


output "practice_asg_name" {
  description = "outputs the ASG name"
  value       = module.infra.practice_asg_name
}


output "public_ec2s_ips" {
  description = "this will output the public ips of the public ec2S"
  value       = module.infra.public_ec2s_ips
}
