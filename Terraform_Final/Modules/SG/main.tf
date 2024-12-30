# Security Group
# Two is need one for ec2, and one for ALB
# For EC2 = SSH (22) , HTTP(80) , and HTTPS( 443)
#For ALB = Allow HTTP (80), and HTTP(443)


#made changes

// Inside ../SG/main.tf or similar


// Rest of your SG module configuration

locals {
  default_tags = merge(
    var.default_tags,
    { "Env" = var.env }
  )
  name_prefix = "${var.prefix}-${var.env}"
}


resource "aws_security_group" "http_sg" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.default_tags, {
    "Name" = "${local.name_prefix}-http-sg"
  })
}





resource "aws_security_group" "ssh_sg" {
  name        = "allow_ssh for bastion"
  description = "Allow SSH inbound traffic from Bastion"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.default_tags, {
    "Name" = "${local.name_prefix}-ssh-sg"
  })
}


resource "aws_security_group" "ssh_webservers_sg" {
  name        = "allow_ssh for prviate"
  description = "Allow SSH inbound traffic from Bastion"
  vpc_id      = var.vpc_id
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = var.ssh_webservers
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.default_tags, {
    "Name" = "${local.name_prefix}-ssh-sg"
  })
}