locals {
  default_tags = merge(
    var.default_tags,
    { "Env" = var.env }
  )
  name_prefix = "${var.prefix}-${var.env}"
}



data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
resource "aws_launch_template" "my_webservers" {
  name          = "my_webservers_template"
  image_id      = data.aws_ami.latest_amazon_linux.id
  instance_type = lookup(var.instance_type, var.env)
  key_name      = var.key_name_webservers









  network_interfaces {
    associate_public_ip_address = false
    security_groups             = var.security_group_id

  }





  tag_specifications {
    resource_type = "instance"
    tags = merge(local.default_tags, {
      "Name" = "${local.name_prefix}-Amazon-Linux"
    })
  }
}