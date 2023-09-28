output "target_group_arn" {
  value = [for idx, val in aws_lb_target_group.target_group : val.arn]
}

output "lb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "lb_canonical_hostedzoneid" {
  value = aws_lb.alb.zone_id
}

output "lb_listener" {
  value = aws_lb_listener.lb_listener
}

output "zone_id" {
  value = aws_lb.alb.zone_id
}