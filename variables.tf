variable "aws_region" {
  description = "The AWS region to use"
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  default = "10.0.2.0/24"
}

variable "instance_ami" {
  description = "AMI ID for the EC2 instance"
  default = "ami-007855ac798b5175e"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default = "t2.micro"
}

variable "ssh_public_key" {
  description = "Path to the public key for SSH access to the EC2 instance"
  default = "~/.ssh/my-key-pair.pub"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

