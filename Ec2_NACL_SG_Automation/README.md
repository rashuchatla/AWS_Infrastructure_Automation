Implementing

![Alt text](<Screenshot 2023-11-21 at 4.43.46 PM.png>)

1. create VPC
2. create EC2 with the above created VPC
3. run python server using python3 -m http server 8000
4. Enable traffic to the python app port 8000 in the security group, as by default SG will deny all inbound traffic

