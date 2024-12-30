output "alb_id" {
  value = aws_alb_target_group.alb_targetgroup.arn
}

output "target_group_arn" {
  value = aws_alb_target_group.alb_targetgroup.arn
}

output "alb_dns_name" {
  value = aws_alb.webservers_load_balancer.dns_name
}