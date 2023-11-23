we create below resources using Terraform code

- Create 1 VPC
- Create 2 Private Subnets, 2 Public Subnets across two AZs
- Create Internet Gateway
- Create 1 NAT Gateway
- Create 1 Public and 1 Private route table for public and private subnets routes
- Attach Internet Gateway to public route table
- Attach NAT Gateway to the private route table
- Attach private route table to private subnets
- Attach public route table to public subnets


More details here
https://medium.com/@rchtech/create-production-level-vpc-in-aws-using-terraform-69686388fa30
