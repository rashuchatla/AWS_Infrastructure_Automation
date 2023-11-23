variable "vpc_cidr"{
    type = string
    description = "VPC cidr block"
    default = "10.0.0.0/16"
}

variable "az_names" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidr" {
  description = "Public Subnet cidr block"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr" {
  description = "Private Subnet cidr block"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Launch Template and ASG Variables

variable "ami" {
  description = "ami id"
  type        = string
  default     = "ami-006dcf34c09e50022"
}
variable "aws_region" {
  description = "AWS region name"
  type        = string
  default     = "us-east-1"
  }

variable "server_port" {
  description = "The port the web server will be listening"
  type        = number
  default     = 8080
}

variable "elb_port" {
  description = "The port the elb will be listening"
  type        = number
  default     = 80
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
  default     = "t2.micro"
}

variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
  default     = 5
}

variable "desired_capacity" {
  description = "The desired number of EC2 Instances in the ASG"
  type        = number
  default     = 3
}

# Local Values
locals {
  vpc_name                 = "project_vpc"
  internet_gateway_name    = "project-internet-gateway"
  public_subnet_name       = "project-public-subnet"
  private_subnet_name      = "project-private-subnet"
  public_route_table_name  = "project-public-route-table"
  private_route_table_name = "project-private-route-table"
  elastic_ip_name          = "project-nat-elastic-ip"
  nat_gateway_name         = "project-nat-gateway"
  launch_template_name     = "project-launch-template"
  launch_template_ec2_name = "project-asg-ec2"
}