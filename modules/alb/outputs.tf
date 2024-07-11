output "load_balancer_dns" {
  value = aws_lb.api.dns_name
}

output "security_groups_alb" {
  value = aws_security_group.alb_sg.id 
}

output "lb_target_group_arn" {
  value = aws_lb_target_group.api.arn
}