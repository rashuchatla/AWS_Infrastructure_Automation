provider "aws"{
    region = "us-east-1"
}

resource "aws_vpc" "project_vpc"{
    cidr_block = var.vpc_cidr
    tags = {
        Name = local.vpc_name
    }
}

resource "aws_subnet" "public_subnets"{
    count = length(var.public_subnet_cidr)
    vpc_id = aws_vpc.project_vpc.id
    cidr_block = var.public_subnet_cidr[count.index]
    availability_zone = var.az_names[count.index]
    tags = {
      Name = join("-",[local.public_subnet_name, var.az_names[count.index]])
    }
}

resource "aws_subnet" "private_subnets"{
    count = length(var.private_subnet_cidr)
    vpc_id = aws_vpc.project_vpc.id
    cidr_block = var.private_subnet_cidr[count.index]
    availability_zone = var.az_names[count.index]
    tags = {
      Name = join("-",[local.private_subnet_name, var.az_names[count.index]])
    }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.project_vpc.id

  tags = {
    Name = local.internet_gateway_name
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  
 tags = {
    Name = local.public_route_table_name
  }
}

resource "aws_eip" "elastic_ip" {
  tags = {
    Name = local.elastic_ip_name
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id     = aws_eip.elastic_ip.id
  subnet_id         = aws_subnet.public_subnets[0].id

  tags = {
    Name = local.nat_gateway_name
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  
tags = {
    Name = local.private_route_table_name
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  count          = 2
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_rt_assoc" {
  count          = 2
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

# Launch Template and ASG Resources

resource "aws_launch_template" "launch_template" {
  name          = local.launch_template_name
  image_id      = var.ami
  instance_type = var.instance_type

  tag_specifications {
    resource_type = "instance"
    tags = {
     Name = local.launch_template_ec2_name
    }
  }
}

resource "aws_autoscaling_group" "auto_scaling_group" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = [for i in aws_subnet.private_subnets[*] : i.id]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}