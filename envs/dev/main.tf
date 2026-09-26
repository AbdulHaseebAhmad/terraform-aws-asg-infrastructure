module "infra" {
  source = "../../module/infra"

  vpc_cidr           = var.vpc_cidr
  aws_region         = var.aws_region
  environment_name   = var.environment_name
  public_cidrs       = var.public_cidrs
  private_cidrs      = var.private_cidrs
  availability_zones = var.availability_zones
  asg_config         = var.asg_config

}