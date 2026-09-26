resource "aws_vpc" "practice_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.environment_name}-practice-vpc"
    Environment = var.environment_name
  }
}