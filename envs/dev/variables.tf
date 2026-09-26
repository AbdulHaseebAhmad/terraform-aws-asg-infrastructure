variable "aws_region" {
  type        = string
  description = "This describes the AWS Region for the infra"
}

variable "environment_name" {
  type        = string
  description = "The working environment for the infra"
}

variable "vpc_cidr" {
  type        = string
  description = "The cidr range for the vpc"
}

variable "public_cidrs" {
  type        = list(string)
  description = "The cidr ranges for the two public subnets"
}

variable "private_cidrs" {
  type        = list(string)
  description = "The cidr ranges for the two private subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "The availability_zones for the subnets"
}

variable "asg_config" {
  type = object({
    min_size                  = number
    max_size                  = number
    desired_capacity          = number
    health_check_grace_period = number
    health_check_type         = string

  })

  description = "Contains Configs for the ASG"
}