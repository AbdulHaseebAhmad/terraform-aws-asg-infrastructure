# Terraform AWS Auto Scaling Infrastructure

A hands-on Terraform demonstrator for building and testing scalable AWS infrastructure using **Launch Templates, Auto Scaling Groups, and an Application Load Balancer**.

The purpose of this project is to understand how these AWS components work together and to demonstrate how infrastructure responds when application demand increases.

> **Note:** This project is a demonstrator for learning and portfolio purposes. The infrastructure and security configuration are intentionally simplified and should not be considered a production-ready architecture.

---

## Objective

The main objective of this project is to demonstrate:

* Infrastructure provisioning with Terraform
* AWS networking across multiple Availability Zones
* Launch Templates for EC2 instance configuration
* Auto Scaling Groups for managing EC2 capacity
* Application Load Balancing
* Target Group health checks
* Target Tracking Auto Scaling based on CPU utilization
* EC2 user data for instance bootstrapping
* Environment-specific configuration for Dev and Prod
* Testing infrastructure behavior under CPU load

The main scaling flow demonstrated by this project is:

```text
CPU Load
   ↓
CloudWatch CPU Metric
   ↓
Target Tracking Policy
   ↓
Auto Scaling Group
   ↓
Launch Template
   ↓
New EC2 Instance
```

---

## Architecture

The infrastructure consists of:

* VPC
* 2 Availability Zones
* 2 Public Subnets
* 2 Private Subnets
* Internet Gateway
* NAT Gateway
* Public and Private Route Tables
* Application Load Balancer
* Target Group
* Launch Templates
* Auto Scaling Groups
* Target Tracking Scaling Policies
* Security Groups
* Nginx
* EC2 User Data

The application instances are managed by Auto Scaling Groups rather than being created individually with `aws_instance`.

---

## Repository Structure

```text
terraform-aws-asg-infrastructure/
├── README.md
├── .gitignore
├── envs/
│   ├── dev/
│   └── prod/
└── module/
    └── infra/
```

The `envs` directory contains environment-specific configuration, while the `module` directory contains the reusable infrastructure configuration.

---

# Testing the Infrastructure

The infrastructure was tested progressively, starting with instance initialization and ending with Auto Scaling under CPU load.

## 1. Test EC2 User Data

The Launch Template uses a user data script to install and configure Nginx.

After an EC2 instance has been launched, SSH into the instance.

Test Nginx:

```bash
curl localhost
```

Expected response:

```html
<h1>Hello from <hostname></h1>
```

The hostname should be the hostname of the EC2 instance.

This verifies that:

* The EC2 instance launched successfully
* The Launch Template was used
* The user data script executed
* Nginx was installed
* Nginx started successfully
* The custom HTML page was created

---

## 2. Test the Application Load Balancer

SSH into the bastion/public instance.

From the bastion, send a request to the Application Load Balancer:

```bash
curl http://<ALB-DNS>
```

Replace `<ALB-DNS>` with the DNS name of the Application Load Balancer.

Expected response:

```html
<h1>Hello from <hostname></h1>
```

This verifies the following path:

```text
Bastion
   ↓
Application Load Balancer
   ↓
Target Group
   ↓
Private ASG Instance
   ↓
Nginx
```

The Target Group should also show the registered instances as:

```text
healthy
```

This confirms that the ALB can communicate with the application instances and that the health checks are passing.

---

## 3. Test Auto Scaling

The Auto Scaling Groups use **Target Tracking Scaling** based on average CPU utilization.

The target configured for the demonstrator is:

```text
60% average CPU utilization
```

To test the scaling behavior, generate CPU load on an instance.

### Install stress-ng

If it is not already installed:

```bash
sudo apt update -y
sudo apt install -y stress-ng
```

### Generate CPU Load

Run:

```bash
nohup stress-ng --cpu 2 --cpu-load 100 --timeout 30m > ~/stress.log 2>&1 &
```

The command runs the CPU stress test in the background.

The options mean:

```text
nohup              Keep running after SSH session closes
--cpu 2            Create two CPU workers
--cpu-load 100     Target 100% CPU utilization
--timeout 30m      Run for 30 minutes
> ~/stress.log     Write output to stress.log
2>&1               Redirect errors to the same log
&                  Run in the background
```

The CPU load can be checked with:

```bash
top
```

or:

```bash
htop
```

---

## 4. Monitor the Auto Scaling Group

From the machine where the AWS CLI is configured, run:

```bash
watch -n 30 'aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names prod-practice-asg --query "AutoScalingGroups[0].{Desired:DesiredCapacity,Min:MinSize,Max:MaxSize,Instances:Instances[*].InstanceId}"'
```

Initially, the ASG will show its configured desired capacity.

As CPU utilization remains above the target, the Target Tracking policy should cause the Auto Scaling Group to increase its desired capacity.

A new EC2 instance should then be launched using the Launch Template.

The new instance should subsequently:

1. Launch from the Launch Template
2. Execute the user data script
3. Install and start Nginx
4. Register with the Target Group
5. Pass the Target Group health check

---

## 5. Stop the CPU Test

After completing the scaling test:

```bash
pkill stress-ng
```

The CPU load will stop.

The Auto Scaling Group can then respond to the reduced CPU utilization and eventually scale back toward its configured minimum capacity.

---

# Demonstrated Infrastructure Flow

The complete test demonstrates the following:

```text
Terraform
    ↓
AWS Infrastructure
    ↓
Launch Template
    ↓
Auto Scaling Group
    ↓
EC2 Instance
    ↓
User Data
    ↓
Nginx
    ↓
Target Group
    ↓
Application Load Balancer
    ↓
Application Response
```

And under increased CPU load:

```text
CPU Load
    ↓
CloudWatch Metric
    ↓
Target Tracking Policy
    ↓
Auto Scaling Group
    ↓
Increase Desired Capacity
    ↓
Launch New EC2 Instance
    ↓
Launch Template
    ↓
User Data
    ↓
Nginx
    ↓
Target Group
```

---

## What This Project Demonstrates

This project was built to move beyond simply learning Terraform syntax and demonstrate how Terraform-managed AWS infrastructure behaves in practice.

The testing covers:

* EC2 instance bootstrapping
* Nginx deployment through user data
* Application Load Balancing
* Target Group health checks
* Communication between the ALB and private instances
* CPU-based Auto Scaling
* Automatic EC2 instance provisioning
* Launch Template reuse
* Infrastructure behavior under simulated load

---

## Important Note

This is a **learning and portfolio demonstrator**, not a production deployment.

Some configuration choices are intentionally simplified so the focus remains on understanding:

**Terraform → AWS Networking → Launch Templates → Auto Scaling → Load Balancing → Scaling Behavior**

The infrastructure can be extended and hardened further for production use.

