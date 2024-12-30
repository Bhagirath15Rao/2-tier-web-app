#Auto Scaling Group
# Scaling policies( If CPU>10% then Instace +1  or  IF CPU<5% Instace-1 )
# lauch templete if instace happen to be +1 
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm

locals {
  default_tags = merge(
    var.default_tags,
    { "Env" = var.env }
  )
  name_prefix = "${var.prefix}-${var.env}"
}
resource "aws_autoscaling_group" "asg" {
  launch_template {
    id      = var.launch_configuration_name
    version = "$Latest"
  }
  vpc_zone_identifier       = var.public_subnet
  max_size                  = var.max_size
  min_size                  = var.min_size
  target_group_arns         = var.target_group_arns
  health_check_type         = "EC2"
  desired_capacity          = var.desired_capacity
  force_delete              = true
  wait_for_capacity_timeout = "0"

  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-asg"
    propagate_at_launch = false
  }

  dynamic "tag" {
    for_each = local.default_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = false
    }
  }


  dynamic "tag" {
    for_each = local.default_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}



resource "aws_autoscaling_policy" "scale_up" {
  name                   = "add-to-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name



}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "remove-one-to-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name


}

resource "aws_cloudwatch_metric_alarm" "high_cpu_usage" {
  alarm_name                = "higher-than-10per-cpu-usage"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "240"
  statistic                 = "Average"
  threshold                 = "10"
  alarm_actions             = [aws_autoscaling_policy.scale_up.arn]
  alarm_description         = "Alarm triggers if CPU usage exceeds 10%, adding an instance"
  insufficient_data_actions = []
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }
  tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-high-cpu-usage-alarm"
    }
  )
}

resource "aws_cloudwatch_metric_alarm" "low_cpu_usage" {
  alarm_name                = "lower-than-5per-cpu-usage"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "240"
  statistic                 = "Average"
  threshold                 = "5"
  alarm_actions             = [aws_autoscaling_policy.scale_down.arn]
  alarm_description         = "Alarm triggers if CPU usage falls below 5%, removing an instance"
  insufficient_data_actions = []
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }
  tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-low-cpu-usage-alarm"
    }
  )
}