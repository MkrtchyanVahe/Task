#----------Set up a security group allowing inbound traffic on ports 80 (HTTP), 443 (HTTPS), and 22 (SSH) from your IP address-------

resource "aws_security_group" "elb_sg" {
  name_prefix = "elb_sg"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.public_subnet_cidr_block]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [var.public_subnet_cidr_block]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [var.public_subnet_cidr_block]
  }
}

#--------Create an Elastic Load Balancer (ELB) with a listener for port 80----------------
resource "aws_elb" "my-elb" {
  name = "my-elb"
  availability_zones = var.availability_zones
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

#  access_logs {
#    bucket        = aws_s3_bucket.example_bucket.id
#    bucket_prefix = "${var.account_id}/elasticloadbalancing"
#    enabled       = true
#  }
# 
  security_groups = [aws_security_group.elb_sg.id]
}

