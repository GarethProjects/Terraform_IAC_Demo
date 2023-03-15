#############################################################################
# Resources BLOCK 
#############################################################################


# Resources Block
# Resource-1: Create VPC
resource "aws_vpc" "vpc-dev-demopipeline" {
  cidr_block = var.cidr_addr_range
  tags = {
    "Name" = var.input_vpc_name
  }
}

# Resource-2: Create Subnet
resource "aws_subnet" "vpc-dev-public-subnet-1" {
  vpc_id                  = aws_vpc.vpc-dev-demopipeline.id
  cidr_block              = "172.16.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

# Resource-3: Internet Gateway
resource "aws_internet_gateway" "vpc-dev-igw" {
  vpc_id = aws_vpc.vpc-dev-demopipeline.id
}

# Resource-4: Create Route Table
resource "aws_route_table" "vpc-dev-public-route-table" {
  vpc_id = aws_vpc.vpc-dev-demopipeline.id
}

# Resource-5: Create Route in Route Table for Internet Access
resource "aws_route" "vpc-dev-public-route" {
  route_table_id         = aws_route_table.vpc-dev-public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc-dev-igw.id
}

# Resource-6: Associate the Route Table with the Subnet
resource "aws_route_table_association" "vpc-dev-public-route-table-associate" {
  route_table_id = aws_route_table.vpc-dev-public-route-table.id
  subnet_id      = aws_subnet.vpc-dev-public-subnet-1.id
}

# Resource-7: Create Security Group
resource "aws_security_group" "dev-vpc-sg" {
  name        = "dev-vpc-default-sg"
  description = "Dev VPC Default Security Group"
  vpc_id      = aws_vpc.vpc-dev-demopipeline.id

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all IP and Ports Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Resource-8: Create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami                    = "ami-0dfcb1ef8550277af" # Amazon Linux us-east-1
  instance_type          = "t2.micro"
  key_name               = "terraform-key"
  subnet_id              = aws_subnet.vpc-dev-public-subnet-1.id
  vpc_security_group_ids = [aws_security_group.dev-vpc-sg.id]
  #user_data = file("apache-install.sh")
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "This is just to demo the script for testing" > /var/www/html/index.html
    EOF
  tags = {
    "Name" = "myec2vm"
  }    
}

# Day N Configuration changes required
# We now have a request to add a new subnet to our existing infrastructure
# Steps involved to do this
# 1 Checkout source code from git repository
# 1.1 git pull git repo url 
# 2 Write the code required locally through an IDE Visual studio for example
# 3 Push the changes required to Dev Branch using the usual git commands
# 4 changes in git now automatically trigger the workflow shown in our diagram

# # Resource-9: Create Subnet after original IAC code has been built
resource "aws_subnet" "vpc-dev-public-subnetdayN-2" {
  vpc_id                  = aws_vpc.vpc-dev.id
  cidr_block              = "172.16.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
}

# # Resource-10: Create Route Table
resource "aws_route_table" "vpc-dev-new-private-route-table" {
  vpc_id = aws_vpc.vpc-dev.id
}

# # Resource-11: Associate the Route Table with the new Subnet
resource "aws_route_table_association" "vpc-dev-private-route-table-associate" {
  route_table_id = aws_route_table.vpc-dev-new-private-route-table.id
  subnet_id      = aws_subnet.vpc-dev-public-subnetdayN-2.id
}



# # Resource-10: Create Subnet after original IAC code has been built
# resource "aws_subnet" "vpc-dev-public-subnetdayN-2" {
#   vpc_id                  = aws_vpc.vpc-dev.id
#   cidr_block              = "172.16.2.0/24"
#   availability_zone       = "us-east-1a"
#   map_public_ip_on_launch = false
# }

# # Resource-11: Create Route Table
# resource "aws_route_table" "vpc-dev-new-private-route-table" {
#   vpc_id = aws_vpc.vpc-dev.id
# }

# # Resource-12: Associate the Route Table with the new Subnet
# resource "aws_route_table_association" "vpc-dev-private-route-table-associate" {
#   route_table_id = aws_route_table.vpc-dev-new-private-route-table.id
#   subnet_id      = aws_subnet.vpc-dev-public-subnetdayN-2.id
# }


# Resource-10: Create Subnet after original IAC code has been built
resource "aws_subnet" "vpc-dev-public-subnetdayN-2" {
  vpc_id                  = aws_vpc.vpc-dev-demopipeline.id
  cidr_block              = "172.16.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
}

# Resource-11: Create Route Table
resource "aws_route_table" "vpc-dev-new-private-route-table" {
  vpc_id = aws_vpc.vpc-dev.id
}

# Resource-12: Associate the Route Table with the new Subnet
resource "aws_route_table_association" "vpc-dev-private-route-table-associate" {
  route_table_id = aws_route_table.vpc-dev-new-private-route-table.id
  subnet_id      = aws_subnet.vpc-dev-public-subnetdayN-2.id
}


# # Resource-10: Create Subnet after original IAC code has been built
# resource "aws_subnet" "vpc-dev-public-subnetdayN-2" {
#   vpc_id                  = aws_vpc.vpc-dev-demopipeline.id
#   cidr_block              = "172.16.2.0/24"
#   availability_zone       = "us-east-1a"
#   map_public_ip_on_launch = false
# }

# # Resource-11: Create Route Table
# resource "aws_route_table" "vpc-dev-new-private-route-table" {
#   vpc_id = aws_vpc.vpc-dev.id
# }

# # Resource-12: Associate the Route Table with the new Subnet
# resource "aws_route_table_association" "vpc-dev-private-route-table-associate" {
#   route_table_id = aws_route_table.vpc-dev-new-private-route-table.id
#   subnet_id      = aws_subnet.vpc-dev-public-subnetdayN-2.id
# }

# # Resource-10: Create Subnet after original IAC code has been built
# resource "aws_subnet" "vpc-dev-public-subnetdayN-2" {
#   vpc_id                  = aws_vpc.vpc-dev-demopipeline.id
#   cidr_block              = "172.16.2.0/24"
#   availability_zone       = "us-east-1a"
#   map_public_ip_on_launch = false
# }

# # Resource-11: Create Route Table
# resource "aws_route_table" "vpc-dev-new-private-route-table" {
#   vpc_id = aws_vpc.vpc-dev.id
# }

# # Resource-12: Associate the Route Table with the new Subnet
# resource "aws_route_table_association" "vpc-dev-private-route-table-associate" {
#   route_table_id = aws_route_table.vpc-dev-new-private-route-table.id
#   subnet_id      = aws_subnet.vpc-dev-public-subnetdayN-2.id
# }

