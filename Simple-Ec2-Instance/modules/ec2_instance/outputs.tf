output "public_ip"{
    description = "Public IP of the Ec2 Instance"
    value = aws_instance.example.public_ip
}
