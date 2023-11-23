we create
 - 1 VPC
 - 2 Public subnets, 2 Private subnets
 - Internet Gateway, NAT Gateway
 - 1 Public and 1 Private Route Table
 - 1 Auto Scaling Group
- 1 Auto Scaling Group to launch EC2 Instances

Testing:
- We can test by terminating ec2 instance manually from console and check if ASG re-spins instances