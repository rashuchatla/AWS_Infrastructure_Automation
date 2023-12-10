resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "pub_sub_1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.pub_sub_cidr1
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}


resource "aws_subnet" "pub_sub_2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.pub_sub_cidr2
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.pub_sub_1.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.pub_sub_2.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_security_group" "websg" {
  name   = "websg"
  vpc_id = aws_vpc.myvpc.id
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0    #applies to all ports
    to_port     = 0    #applies to all ports
    protocol    = "-1" #all protocols are allowed
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "web-sg"
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "rashmitha2023bucketproject"
}

resource "aws_instance" "webserver1" {
  ami                    = "ami-0261755bbcb8c4a84"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.websg.id]
  subnet_id              = aws_subnet.pub_sub_1.id
  user_data              = base64encode(file("userdata.sh"))
}

resource "aws_instance" "webserver2" {
  ami                    = "ami-0261755bbcb8c4a84"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.websg.id]
  subnet_id              = aws_subnet.pub_sub_2.id
  user_data              = base64encode(file("userdata1.sh"))
}

#create ALB
resource "aws_lb" "websgalb" {
  name               = "websgalb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.websg.id]
  subnets            = [aws_subnet.pub_sub_1.id, aws_subnet.pub_sub_2.id]
  tags = {
    name = "websg"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id
  health_check {
    path = "/"
  }
}

resource "aws_lb_target_group_attachment" "attach1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.webserver1.id
  port             = 80
}


resource "aws_lb_target_group_attachment" "attach2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.webserver2.id
  port             = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.websgalb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type             = "forward"
  }
}