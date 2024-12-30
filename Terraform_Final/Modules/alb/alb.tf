#ALB (To distribute incoming traffic)
#Listener : check for connection and request 
# Traget : Group of instace that receive traffice from ALB
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
#https://github.com/terraform-aws-modules/terraform-aws-alb/tree/v9.2.0/examples/complete-alb


locals {
  default_tags = merge(
    var.default_tags,
    { "Env" = var.env }
  )
  name_prefix = "${var.prefix}-${var.env}"
}

resource "aws_alb" "webservers_load_balancer" {
  name               = "alb-webservers"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet
  security_groups    = var.security_group_id


}

#Traget Group 
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group


#https://aws.amazon.com/what-is/load-balancing/     
# For aglorthim, I will use Least connection method

resource "aws_alb_target_group" "alb_targetgroup" {
  name        = "alb-targetgroup"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  load_balancing_algorithm_type = "least_outstanding_requests"
  tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-alb-target-group"
    }
  )

}

#Listner
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener



resource "aws_alb_listener" "webservers_listener" {
  load_balancer_arn = aws_alb.webservers_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.alb_targetgroup.arn
    type             = "forward"
  }
  tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-alb-listener"
    }
  )
}