# Terraform AWS Infrastructure

A hands-on Terraform project for building AWS infrastructure with a focus on **Auto Scaling Groups, Launch Templates, and Application Load Balancing**.

## Architecture

* VPC across 2 Availability Zones
* Public and private subnets
* Internet Gateway and NAT Gateway
* Application Load Balancer
* Launch Templates
* Auto Scaling Groups
* Target-tracking CPU scaling
* Security Groups
* Environment-specific configuration for `dev` and `prod`

## Structure

```text
terraform_practice/
├── envs/
│   ├── dev/
│   └── prod/
├── module/
│   └── infra/
└── .gitignore
```

## Goal

Build and manage scalable AWS infrastructure using Terraform while practising infrastructure design, modularity, networking, and Auto Scaling.
