#-------Create a VPC with a private and public subnet------

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "example" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.example.id
  cidr_block = var.public_subnet_cidr_block
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.example.id
  cidr_block = var.private_subnet_cidr_block
}

resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.example]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example.id
}

resource "aws_route" "internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.example.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.example.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

#------create ian role-----------

resource "aws_iam_role" "demo" {
  name = "eks-cluster-demo"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo_amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo.name
}

resource "aws_eks_cluster" "demo" {
  name     = "demo"
  version  = "1.24"
  role_arn = aws_iam_role.demo.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private.id,
      aws_subnet.public.id,
     ]
  }

  depends_on = [aws_iam_role_policy_attachment.demo_amazon_eks_cluster_policy]
}

#--------Launch an EC2 instance in the public subnet with an SSH key pair for access.-------

resource "aws_security_group" "instance" {
  name_prefix = "instance"
  vpc_id      = aws_vpc.example.id
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "example" {
  key_name   = "my-key-pair"
  public_key = file(var.ssh_public_key)
}

resource "aws_instance" "example" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.instance.id]
  subnet_id     = aws_subnet.public.id

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 8
  }

  tags = {
    Name = "example"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > index.html
              nohup busybox httpd -f -p 80 &
              EOF
  root_block_device {
    delete_on_termination = true

    }
}

























