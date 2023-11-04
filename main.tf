provider "aws"{
    region = "us-east-1"
}

module "ec2_instance"{
   source = "./modules/ec2_instance"
   ami = "<>"
   instance_type = "t2.micro"
}

#A project - whenever a src code commit is issued, build the project using GitHub Actions and use terraform to 
# spin up Ec2 Instance with required VPC and security groups and deploy the Flask App and access it using instance
#public ip